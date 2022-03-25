terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
  }
}

locals {
  topic_map              = { for topic in var.sns_topics : topic.name => topic }
  topic_subscription_map = { for topic_subscription in var.sns_sqs_subscriptions : topic_subscription.name => topic_subscription }
}

data "aws_kms_key" "sns_alias" {
  key_id = "alias/ops/sns"
}

module "sns_topic" {
  source           = "terraform-aws-modules/sns/aws"
  version          = "~> 3.0"
  for_each         = local.topic_map
  create_sns_topic = true

  name                             = "${var.aws_resource_name_prefix}${each.key}"
  display_name                     = lookup(each.value, "display_name", null)
  fifo_topic                       = lookup(each.value, "fifo_topic", null)
  content_based_deduplication      = lookup(each.value, "content_based_deduplication", null)
  delivery_policy                  = lookup(each.value, "delivery_policy", null)
  sqs_success_feedback_role_arn    = lookup(each.value, "sqs_success_feedback_role_arn", null)
  sqs_success_feedback_sample_rate = lookup(each.value, "sqs_success_feedback_sample_rate", null)
  sqs_failure_feedback_role_arn    = lookup(each.value, "sqs_failure_feedback_role_arn", null)
  kms_master_key_id                = data.aws_kms_key.sns_alias.arn
}

resource "kubernetes_config_map" "sns_topics" {
  for_each = local.topic_map

  metadata {
    name      = "${var.app_name}-sns-topic-${each.key}"
    namespace = var.namespace
  }

  data = {
    "SNS__${each.value.reference}__name" = module.sns_topic[each.key].sns_topic_name
    "SNS__${each.value.reference}__arn"  = module.sns_topic[each.key].sns_topic_arn
  }
}

data "aws_sns_topic" "topics_to_subscribe" {
  for_each = local.topic_subscription_map
  name     = each.value.topic_name
}

module "sqs_queue" {
  source                            = "terraform-aws-modules/sqs/aws"
  version                           = "~> 2.0"
  for_each                          = local.topic_subscription_map
  create                            = true
  name                              = "${var.aws_resource_name_prefix}${each.key}"
  fifo_queue                        = lookup(each.value, "fifo_queue", null)
  visibility_timeout_seconds        = lookup(each.value, "visibility_timeout_seconds", null)
  message_retention_seconds         = lookup(each.value, "message_retention_seconds", null)
  max_message_size                  = lookup(each.value, "max_message_size", null)
  delay_seconds                     = lookup(each.value, "delay_seconds", null)
  receive_wait_time_seconds         = lookup(each.value, "receive_wait_time_seconds", null)
  policy                            = lookup(each.value, "policy", null)
  redrive_policy                    = lookup(each.value, "redrive_policy", null)
  content_based_deduplication       = lookup(each.value, "content_based_deduplication", null)
  kms_master_key_id                 = data.aws_kms_key.sns_alias.arn
  kms_data_key_reuse_period_seconds = lookup(each.value, "kms_data_key_reuse_period_seconds", null)
}

data "aws_iam_policy_document" "topic_subscription_policy" {
  for_each  = local.topic_subscription_map
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
  for_each  = local.topic_subscription_map
  policy    = data.aws_iam_policy_document.topic_subscription_policy[each.key].json
  queue_url = data.aws_sqs_queue.queue_urls[each.key].url
}


resource "aws_sns_topic_subscription" "topic_subscription" {
  for_each             = local.topic_subscription_map
  topic_arn            = data.aws_sns_topic.topics_to_subscribe[each.key].arn
  protocol             = "sqs"
  endpoint             = module.sqs_queue[each.key].this_sqs_queue_arn
  raw_message_delivery = lookup(each.value, "raw_message_delivery", false)
}

locals {
  sqs_queue_arns = [
    for key, queue in local.topic_subscription_map : module.sqs_queue[key].this_sqs_queue_arn
  ]
}

data "aws_iam_policy_document" "sns_publish_policy" {
  for_each  = length(local.topic_map) > 0 ? { "sns_publish_policy" : {} } : {}
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

resource "kubernetes_config_map" "sns_sqs_subscriptions" {
  for_each = local.topic_subscription_map

  metadata {
    name      = "${var.app_name}-sns-sqs-subscription-${each.key}"
    namespace = var.namespace
  }

  data = {
    "SQS__${each.value.reference}__name" = module.sqs_queue[each.key].this_sqs_queue_name
    "SQS__${each.value.reference}__arn"  = module.sqs_queue[each.key].this_sqs_queue_arn
    "SQS__${each.value.reference}__url"  = data.aws_sqs_queue.queue_urls[each.key].url
  }
}


data "aws_iam_policy_document" "queue_receive_policy" {
  for_each = length(local.topic_subscription_map) > 0 ? { "queue_subscription_policy" : {} } : {}
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
