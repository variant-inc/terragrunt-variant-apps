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
    [for label, cm in kubernetes_config_map.sns_sqs_subscription_dlqs : cm.metadata[0].name]
  )
  description = "Config Maps of SNS and SQS"
}

output "policies" {
  description = "AWS IAM Policy document to allow publish to created topic(s)"
  value       = merge(local.sns_policies, local.sqs_policies)
}