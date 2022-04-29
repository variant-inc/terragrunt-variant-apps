locals {
  existing_policy = length(data.aws_iam_policy_document.existing) == 0 ? {} : {
    dynamodb-existing = data.aws_iam_policy_document.existing[0]
  }
  managed_policy = length(local.dynamodb_policies) == 0 ? {} : {
    dynamodb-managed = local.dynamodb_policies
  }
}

output "policies" {
  value       = merge(local.existing_policy, local.managed_policy)
  description = "Dynamodb Managed and Existing Policies"
}

output "config_maps" {
  value = concat(
    [for label, cm in kubernetes_config_map.managed : cm.metadata[0].name],
    [for label, cm in kubernetes_config_map.existing : cm.metadata[0].name],
    [for label, cm in kubernetes_config_map.existing_cross_account : cm.metadata[0].name]
  )
  description = "Config Maps of Dynamodb"
}
