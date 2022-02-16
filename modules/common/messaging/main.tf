locals {
  topic_keys = {
    for key, topic in var.topics : key => keys(var.topics[key])
  }
  topic_sub_keys = {
    for key, topic in var.topic_subscriptions : key => keys(var.topic_subscriptions[key])
  }
}

data "aws_kms_key" "sns_alias" {
  key_id = "alias/ops/sns"
}

module "sns_topic" {
  source           = "terraform-aws-modules/sns/aws"
  version          = "~> 3.0"
  for_each         = var.topics
  create_sns_topic = true

  name                             = each.key
  display_name                     = contains(local.topic_keys[each.key], "display_name") ? each.value.display_name : null
  fifo_topic                       = contains(local.topic_keys[each.key], "fifo_topic") ? each.value.fifo_topic : null
  content_based_deduplication      = contains(local.topic_keys[each.key], "content_based_deduplication") ? each.value.content_based_deduplication : null
  delivery_policy                  = contains(local.topic_keys[each.key], "delivery_policy") ? each.value.delivery_policy : null
  sqs_success_feedback_role_arn    = contains(local.topic_keys[each.key], "sqs_success_feedback_role_arn") ? each.value.sqs_success_feedback_role_arn : null
  sqs_success_feedback_sample_rate = contains(local.topic_keys[each.key], "sqs_success_feedback_sample_rate") ? each.value.sqs_success_feedback_sample_rate : null
  sqs_failure_feedback_role_arn    = contains(local.topic_keys[each.key], "sqs_failure_feedback_role_arn") ? each.value.sqs_success_feedback_role_arn : null
  kms_master_key_id                = data.aws_kms_key.sns_alias.arn
}

data "aws_sns_topic" "topics_to_subscribe" {
  for_each = var.topic_subscriptions
  name     = each.value.topic_name
}

module "sqs_queue" {
  source                            = "terraform-aws-modules/sqs/aws"
  version                           = "~> 2.0"
  for_each                          = var.topic_subscriptions
  create                            = true
  name                              = each.key
  fifo_queue                        = contains(local.topic_sub_keys[each.key], "fifo_queue") ? each.value.fifo_queue : null
  visibility_timeout_seconds        = contains(local.topic_sub_keys[each.key], "visibility_timeout_seconds") ? each.value.visibility_timeout_seconds : null
  message_retention_seconds         = contains(local.topic_sub_keys[each.key], "message_retention_seconds") ? each.value.message_retention_seconds : null
  max_message_size                  = contains(local.topic_sub_keys[each.key], "max_message_size") ? each.value.max_message_size : null
  delay_seconds                     = contains(local.topic_sub_keys[each.key], "delay_seconds") ? each.value.delay_seconds : null
  receive_wait_time_seconds         = contains(local.topic_sub_keys[each.key], "receive_wait_time_seconds") ? each.value.receive_wait_time_seconds : null
  policy                            = contains(local.topic_sub_keys[each.key], "policy") ? each.value.policy : null
  redrive_policy                    = contains(local.topic_sub_keys[each.key], "redrive_policy") ? each.value.redrive_policy : null
  redrive_allow_policy              = contains(local.topic_sub_keys[each.key], "redrive_allow_policy") ? each.value.redrive_allow_policy : null
  content_based_deduplication       = contains(local.topic_sub_keys[each.key], "content_based_deduplication") ? each.value.content_based_deduplication : null
  kms_master_key_id                 = data.aws_kms_key.sns_alias.arn
  kms_data_key_reuse_period_seconds = contains(local.topic_sub_keys[each.key], "kms_data_key_reuse_period_seconds") ? each.value.kms_data_key_reuse_period_seconds : null
}

data "aws_iam_policy_document" "topic_subscription_policy" {
  for_each  = var.topic_subscriptions
  policy_id = "${module.sqs_queue[each.key].this_sqs_queue_name}-subscription"
  version   = "2012-10-17"

  statement {
    effect    = "Allow"
    resources = [module.sqs_queue[each.key].this_sqs_queue_arn]
    actions   = ["sqs:SendMessage"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "ArnEquals"
      values   = [data.aws_sns_topic.topics_to_subscribe[each.key].arn]
      variable = "aws:SourceArn"
    }
  }
}

data "aws_sqs_queue" "queue_urls" {
  for_each = module.sqs_queue
  name     = each.value.this_sqs_queue_name
}

resource "aws_sqs_queue_policy" "topic_subscription_policy_binding" {
  for_each  = var.topic_subscriptions
  policy    = data.aws_iam_policy_document.topic_subscription_policy[each.key].json
  queue_url = data.aws_sqs_queue.queue_urls[each.key].url
}


resource "aws_sns_topic_subscription" "topic_subscription" {
  for_each  = var.topic_subscriptions
  topic_arn = data.aws_sns_topic.topics_to_subscribe[each.key].arn
  protocol  = "sqs"
  endpoint  = module.sqs_queue[each.key].this_sqs_queue_arn
}

locals {
  sqs_queue_arns = [
    for key, queue in var.topic_subscriptions : module.sqs_queue[key].this_sqs_queue_arn
  ]
}

data "aws_iam_policy_document" "sns_publish_policy" {
  for_each  = length(keys(var.topics)) > 0 ? { "sns_publish_policy" : {} } : {}
  policy_id = "SNSTopicsPublish"
  version   = "2012-10-17"
  dynamic "statement" {
    for_each = module.sns_topic
    content {
      effect    = "Allow"
      resources = [statement.value.sns_topic_arn]
      actions   = ["sns:ListSubscriptionsByTopic", "sns:Publish"]
    }
  }
  statement {
    effect    = "Allow"
    resources = [data.aws_kms_key.sns_alias.arn]
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
  }
}


data "aws_iam_policy_document" "queue_receive_policy" {
  for_each = length(keys(var.topic_subscriptions)) > 0 ? { "queue_subscription_policy" : {} } : {}
  version  = "2012-10-17"
  statement {
    effect    = "Allow"
    resources = local.sqs_queue_arns
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage"
    ]
  }

  statement {
    effect    = "Allow"
    resources = [data.aws_kms_key.sns_alias.arn]
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
  }
}

locals {
  topic_env_vars = [for label, topic in module.sns_topic :
    [
      {
        name  = "TOPIC__${label}__name"
        value = topic.sns_topic_name
      },
      {
        name  = "TOPIC__${label}__arn"
        value = topic.sns_topic_arn
      }
    ]
  ]
  queue_env_vars = [for label, queue in module.sqs_queue :
    [
      {
        name  = "QUEUE__${label}__name"
        value = queue.this_sqs_queue_name
      },
      {
        name  = "QUEUE__${label}__arn"
        value = queue.this_sqs_queue_arn
      },
      {
        name  = "QUEUE__${label}__url"
        value = data.aws_sqs_queue.queue_urls[label].url
      }
  ]]
  env_vars = flatten(concat(local.topic_env_vars, local.queue_env_vars))
}
