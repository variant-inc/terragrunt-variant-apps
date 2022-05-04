variable "aws_resource_name_prefix" {
  type        = string
  description = "Prefix of team name to be applied to created resources."
}

variable "sns_topics" {
  type        = any
  default     = {}
  description = "Map of topic objects. Accepts the following values as keys in each object: [display_name, fifo_topic, content_based_deduplication, delivery_policy, sqs_success_feedback_role_arn, sqs_success_feedback_sample_rate, sqs_failure_feedback_role_arn]"
}

variable "sns_sqs_subscriptions" {
  type        = any
  default     = {}
  description = "Map of topic subscription objects. Accepts the following values as keys in each object: [fifo_queue, visibility_timeout_seconds, message_retention_seconds, max_message_size, delay_seconds, receive_wait_time_seconds, content_based_deduplication, kms_data_key_reuse_period_seconds, dlq]"
}

variable "app_name" {
  type        = string
  description = "Release name of the app"
}

variable "namespace" {
  description = "Namespace name of the app"
  type        = string
}