output "policies" {
  value = {
    s3-managed  = data.aws_iam_policy_document.managed
    s3-existing = data.aws_iam_policy_document.existing
  }
}

output "config_maps" {
  value = concat(
    [for label, cm in kubernetes_config_map.managed : cm.metadata[0].name],
    [for label, cm in kubernetes_config_map.existing : cm.metadata[0].name]
  )
}
