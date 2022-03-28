locals {
  topic_map = { for topic in var.topics : topic.name => topic }
  topic_subscription_map = { for topic_subscription in var.topic_subscriptions : topic_subscription.name => topic_subscription }
}

data "aws_kms_key" "sns_alias" {
  key_id = "alias/ops/sns"
}

module "sns_topic" {
  source                           = "github.com/variant-inc/terraform-aws-sns.git?ref=v1"
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


data "aws_sns_topic" "topics_to_subscribe" {
  for_each = local.topic_subscription_map
  name     = each.value.topic_name
}

module "sqs_queue" {
  source                            = "github.com/variant-inc/terraform-aws-sns-subscription-sqs?ref=v1"
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
  redrive_policy                    = lookup(each.value, "redrive_policy", null)
  content_based_deduplication       = lookup(each.value, "content_based_deduplication", null)
  kms_key_sns_arn                   = data.aws_kms_key.sns_alias.arn
  kms_data_key_reuse_period_seconds = lookup(each.value, "kms_data_key_reuse_period_seconds", null)
}
