locals {
  topic_map              = { for topic in var.sns_topics : topic.name => topic }
  topic_subscription_map = { for topic_subscription in var.sns_sqs_subscriptions : topic_subscription.name => topic_subscription }
}

data "aws_kms_key" "sns_alias" {
  key_id = "alias/ops/sns"
}

module "sns_topic" {
  source                           = "github.com/variant-inc/terraform-aws-sns.git?ref=v1.0"
  for_each                         = local.topic_map
  name                             = "${var.aws_resource_name_prefix}${each.key}"
  display_name                     = lookup(each.value, "display_name", null)
  fifo_topic                       = lookup(each.value, "fifo_topic", null)
  content_based_deduplication      = lookup(each.value, "content_based_deduplication", null)
  delivery_policy                  = lookup(each.value, "delivery_policy", null)
  sqs_success_feedback_role_arn    = lookup(each.value, "sqs_success_feedback_role_arn", null)
  sqs_success_feedback_sample_rate = lookup(each.value, "sqs_success_feedback_sample_rate", null)
  sqs_failure_feedback_role_arn    = lookup(each.value, "sqs_failure_feedback_role_arn", null)
  kms_key_sns_arn                  = data.aws_kms_key.sns_alias.arn
}

resource "kubernetes_config_map" "sns_topics" {
  for_each = local.topic_map

  metadata {
    name      = "${var.app_name}-sns-topic-${each.key}"
    namespace = var.namespace
    labels    = var.labels
  }

  data = {
    "SNS__${each.value.reference}__name" = module.sns_topic[each.key].sns_topic_name
    "SNS__${each.value.reference}__arn"  = module.sns_topic[each.key].sns_topic_arn
  }
}

data "aws_sns_topic" "topics_to_subscribe" {
  for_each   = local.topic_subscription_map
  name       = each.value.topic_name
  depends_on = [module.sns_topic]
}

module "sqs_queue" {
  source                            = "github.com/variant-inc/terraform-aws-sns-subscription-sqs?ref=v1.2"
  for_each                          = local.topic_subscription_map
  name                              = "${var.aws_resource_name_prefix}${each.key}"
  topic_arn                         = data.aws_sns_topic.topics_to_subscribe[each.key].arn
  fifo_queue                        = lookup(each.value, "fifo_queue", null)
  visibility_timeout_seconds        = lookup(each.value, "visibility_timeout_seconds", null)
  message_retention_seconds         = lookup(each.value, "message_retention_seconds", null)
  max_message_size                  = lookup(each.value, "max_message_size", null)
  delay_seconds                     = lookup(each.value, "delay_seconds", null)
  receive_wait_time_seconds         = lookup(each.value, "receive_wait_time_seconds", null)
  policy                            = lookup(each.value, "policy", null)
  content_based_deduplication       = lookup(each.value, "content_based_deduplication", null)
  kms_key_sns_arn                   = data.aws_kms_key.sns_alias.arn
  kms_data_key_reuse_period_seconds = lookup(each.value, "kms_data_key_reuse_period_seconds", null)
  dlq_options                       = lookup(each.value, "dlq", {})
  depends_on                        = [module.sns_topic]
}

data "aws_sqs_queue" "queue_urls" {
  for_each = module.sqs_queue
  name     = each.value.sqs_queue_name
}

locals {
  sqs_with_dlq = { for k, v in local.topic_subscription_map : k => v if contains(keys(v), "dlq") }
}

data "aws_sqs_queue" "dlq_queue_urls" {
  for_each = local.sqs_with_dlq
  name     = module.sqs_queue[each.key].sqs_queue_dlq_name
}

resource "kubernetes_config_map" "sns_sqs_subscriptions" {
  for_each = local.topic_subscription_map
  metadata {
    name      = "${var.app_name}-sns-sqs-subscription-${each.key}"
    namespace = var.namespace
    labels    = var.labels
  }

  data = {
    "SQS__${each.value.reference}__name" = module.sqs_queue[each.key].sqs_queue_name
    "SQS__${each.value.reference}__arn"  = module.sqs_queue[each.key].sqs_queue_arn
    "SQS__${each.value.reference}__url"  = data.aws_sqs_queue.queue_urls[each.key].url
  }
}

resource "kubernetes_config_map" "sns_sqs_subscription_dlqs" {
  for_each = local.sqs_with_dlq
  metadata {
    name      = "${var.app_name}-sns-sqs-subscription-dlq-${each.key}"
    namespace = var.namespace
    labels    = var.labels
  }

  data = {
    "DLQ__${each.value.reference}__url" = data.aws_sqs_queue.dlq_queue_urls[each.key].url
    "DLQ__${each.value.reference}__arn" = module.sqs_queue[each.key].sqs_queue_dlq_arn
  }
}

locals {
  sns_policies = merge({ for label, cm in module.sns_topic : label => cm.sns_topic_publish_policy })
  sqs_policies = { for label, cm in module.sqs_queue : label => cm.queue_receive_policy }
}
