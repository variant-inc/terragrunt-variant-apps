output "policies" {
  value = data.aws_iam_policy_document.policies
}

output "config_maps" {
  value = concat(
    [for label, cm in kubernetes_config_map.managed_buckets : cm.metadata[0].name],
    [for label, cm in kubernetes_config_map.existing_buckets : cm.metadata[0].name]
  )
}
