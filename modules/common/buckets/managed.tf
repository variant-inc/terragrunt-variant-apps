locals {
  // Convert the list of inputs into map where each key is the bucket prefix
  managed_map = { for bucket in var.managed : bucket.prefix => bucket }
}

// Create the buckets that are managed and owned by this app
module "buckets" {
  for_each = local.managed_map
  source   = "github.com/variant-inc/terraform-aws-s3.git?ref=v1.1.0"

  bucket_prefix = "${var.aws_resource_name_prefix}${each.value.prefix}"
}

// Get the AWS reference of the created managed buckets
data "aws_s3_bucket" "managed" {
  for_each = module.buckets
  bucket   = each.value.bucket_name
}

// Create a ConfigMap per managed bucket for this app
resource "kubernetes_config_map" "managed" {
  for_each = data.aws_s3_bucket.managed

  metadata {
    name      = "${var.app_name}-bucket-${each.key}"
    namespace = var.namespace
  }

  data = {
    "BUCKET__${each.key}__arn"  = each.value.arn
    "BUCKET__${each.key}__name" = each.value.bucket
  }
}

// Create a read/write policy for the managed buckets
data "aws_iam_policy_document" "managed" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetObjectAcl",
      "s3:DeleteObject"
    ]

    resources = flatten([for label, configmap in kubernetes_config_map.managed : [
      lookup(configmap.data, "BUCKET__${label}__arn", null),
      "${lookup(configmap.data, "BUCKET__${label}__arn", null)}/*"
      ]
    ])
  }
}
