output "env_vars" {
  value = local.env_vars
}

output "all_buckets" {
  value = local.all_buckets
}

output "policies" {
  value = data.aws_iam_policy_document.policies
}

output "config_maps" {
  value = [for cm in kubernetes_config_map.managed_buckets : cm.metadata.name]
}
