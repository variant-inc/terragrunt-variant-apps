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
  value = [for label, cm in kubernetes_config_map.managed_buckets : cm.metadata[0].name]
}
