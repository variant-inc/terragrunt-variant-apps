locals {
  # Convert the list of inputs into map where each key is the bucket prefix
  existing_with_cm_map = { for existing in var.existing : existing.bucket_prefix => defaults(existing, { read_only = true }) if existing.bucket_prefix != null }
  existing_wo_cm_map   = { for bucket in var.existing : bucket.reference => defaults(bucket, { read_only = true }) if bucket.full_name != null }
}


# Find ConfigMaps for each bucket owned by other apps
data "kubernetes_config_map" "existing" {
  for_each = local.existing_with_cm_map

  metadata {
    name      = "${each.value.project_name}-bucket-${each.key}"
    namespace = each.value.project_group
  }
}

# Create a copy of the bucket configuration of another app for this app
resource "kubernetes_config_map" "existing" {
  for_each = data.kubernetes_config_map.existing

  metadata {
    name      = "${var.app_name}-bucket-${each.key}"
    namespace = var.namespace
    labels    = var.labels
  }

  data = {
    "BUCKET__${local.existing_with_cm_map[each.key].reference}__arn"  = "arn:aws:s3:::${lookup(each.value.data, "BUCKET__${each.key}", "")}"
    "BUCKET__${local.existing_with_cm_map[each.key].reference}__name" = lookup(each.value.data, "BUCKET__${each.key}", "")
  }
}

resource "kubernetes_config_map" "existing_wo_configmap" {
  for_each = local.existing_wo_cm_map

  metadata {
    name      = "${var.app_name}-bucket-${replace(each.key, "_", "-")}"
    namespace = var.namespace
    labels    = var.labels
  }

  data = {
    "BUCKET__${each.key}__arn"  = "arn:aws:s3:::${each.value.full_name}"
    "BUCKET__${each.key}__name" = each.value.full_name
  }
}

locals {
  read_only_policy = [
    "s3:ListBucket",
    "s3:GetObject",
    "s3:GetObjectVersion",
    "s3:GetObjectAcl"
  ]

  rw_policy = [
    "s3:DeleteObject",
    "s3:GetObject",
    "s3:GetObjectAcl",
    "s3:GetObjectVersion",
    "s3:ListBucket",
    "s3:PutObject",
    "s3:PutObjectAcl"
  ]
}
# Create a read policy for the existing buckets
data "aws_iam_policy_document" "existing" {
  count = length(var.existing) > 0 ? 1 : 0

  dynamic "statement" {
    for_each = local.existing_with_cm_map
    content {
      effect  = "Allow"
      actions = statement.value.read_only ? local.read_only_policy : local.rw_policy
      resources = [
        lookup(kubernetes_config_map.existing[statement.key].data, "BUCKET__${statement.value.reference}__arn", null),
        "${lookup(kubernetes_config_map.existing[statement.key].data, "BUCKET__${statement.value.reference}__arn", null)}/*"
      ]
    }
  }

  dynamic "statement" {
    for_each = local.existing_wo_cm_map
    content {
      effect  = "Allow"
      actions = statement.value.read_only ? local.read_only_policy : local.rw_policy
      resources = [
        "arn:aws:s3:::${statement.value.full_name}",
        "arn:aws:s3:::${statement.value.full_name}/*"
      ]
    }
  }
}
