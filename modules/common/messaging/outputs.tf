output "sns_topics" {
  description = "SNS Topics Output"
  value       = module.sns_topic.*
}

output "sqs_queues" {
  description = "SQS Queues Output"
  value       = module.sqs_queue.*
}