output "sns_topics" {
  description = "SNS Topics Output"
  value       = module.sns_topic.*
}

output "sqs_queues" {
  description = "SQS Queues Output"
  value       = module.sqs_queue.*
}

output "env_vars" {
  description = "Environment variables for app use."
  value       = local.env_vars
}

output "sns_topic_publish_policy" {
  description = "AWS IAM Policy document to allow publish to created topic(s)"
  value       = data.aws_iam_policy_document.sns_publish_policy
}

output "queue_receive_policy" {
  description = "AWS IAM Policy document to allow message recieve to created queue(s)"
  value       = data.aws_iam_policy_document.queue_receive_policy
}

