output "sns_topics" {
  description = "SNS Topics Output"
  value       = module.sns_topic.*
}

output "sqs_queues" {
  description = "SQS Queues Output"
  value       = module.sqs_queue.*
}

output "env_vars" {
  value = local.env_vars
}

output "sns_topic_publish_policy" {
  value = data.aws_iam_policy_document.sns_publish_policy
}

output "queue_receive_policy" {
  value = data.aws_iam_policy_document.queue_receive_policy
}

