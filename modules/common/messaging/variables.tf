variable "topics" {
  type        = map(any)
  default     = {}
  description = "Map of topic objects. Accepts the following values as keys in each object: [display_name, fifo_topic, content_based_deduplication, delivery_policy, sqs_success_feedback_role_arn, sqs_success_feedback_sample_rate, sqs_failure_feedback_role_arn]"
}

variable "topic_subscriptions" {
  type        = map(any)
  default     = {}
  description = "Map of topic subscription objects. Accepts the following values as keys in each object: [fifo_queue, visibility_timeout_seconds, message_retention_seconds, max_message_size, delay_seconds, receive_wait_time_seconds, redrive_policy, content_based_deduplication, kms_data_key_reuse_period_seconds]"
}