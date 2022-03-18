locals {
  existing_policy = length(data.aws_iam_policy_document.existing) == 0 ? {} : {
    s3-existing = data.aws_iam_policy_document.existing[0]
  }
  managed_policy = length(data.aws_iam_policy_document.managed) == 0 ? {} : {
    s3-managed = data.aws_iam_policy_document.managed[0]
  }
}

output "policies" {
  value = merge(local.existing_policy, local.managed_policy)
}

output "config_maps" {
  value = concat(
    [for label, cm in kubernetes_config_map.managed : cm.metadata[0].name],
    [for label, cm in kubernetes_config_map.existing : cm.metadata[0].name],
    [for label, cm in kubernetes_config_map.existing2 : cm.metadata[0].name]
  )
}
