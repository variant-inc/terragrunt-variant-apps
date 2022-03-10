locals {
  // Convert the list of inputs into map where each key is the bucket prefix
  existing_map = { for existing in var.existing : existing.bucket_prefix => existing }
}

// Find ConfigMaps for each bucket owned by other apps
data "kubernetes_config_map" "existing" {
  for_each = local.existing_map

  metadata {
    name      = "${each.value.project_name}-bucket-${each.key}"
    namespace = each.value.project_group
  }
}

// Create a copy of the bucket configuration of another app for this app
resource "kubernetes_config_map" "existing" {
  for_each = data.kubernetes_config_map.existing

  metadata {
    name      = "${var.app_name}-bucketref-${each.key}"
    namespace = var.namespace
  }

  data = each.value.data
}

// Create a read policy for the existing buckets
data "aws_iam_policy_document" "existing" {
  count = length(var.existing) > 0 ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetObjectAcl"
    ]

    resources = flatten([for label, configmap in kubernetes_config_map.existing : [
      lookup(configmap.data, "BUCKET__${label}__arn", null),
      "${lookup(configmap.data, "BUCKET__${label}__arn", null)}/*"
      ]
    ])
  }
}
