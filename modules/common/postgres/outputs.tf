output "policy" {
  value = length(data.aws_iam_policy_document.policies) == 0 ? {} : {
    database_users = data.aws_iam_policy_document.policies[0]
  }
  description = "IAM Policy for Database"
}

output "config_maps" {
  value       = [for label, cm in kubernetes_config_map.postgres : cm.metadata[0].name]
  description = "Config Map for Postgres"
}

output "database_map" {
  value       = local.database_map
  description = "Database Map"
}