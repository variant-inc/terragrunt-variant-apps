output "sns_topics" {
  description = "SNS Topics Output"
  value       = module.sns_topic.*
}

output "sqs_queues" {
  description = "SQS Queues Output"
  value       = module.sqs_queue.*
}

output "config_maps" {
  value = concat(
    [for label, cm in kubernetes_config_map.sns_topics : cm.metadata[0].name],
    [for label, cm in kubernetes_config_map.sns_sqs_subscriptions : cm.metadata[0].name],
  )
}