terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8"
    }
  }
}

locals {
  // Convert the list of inputs into map where each key is the bucket prefix
  managed_map     = { for bucket in var.managed : bucket.prefix => bucket }
  existing_map    = { for existing in var.existing : existing.bucket_prefix => existing }
  all_config_maps = merge(kubernetes_config_map.managed_buckets, kubernetes_config_map.existing_buckets)
}

// Create the buckets that are managed and owned by this app
module "buckets" {
  for_each = local.managed_map
  source   = "github.com/variant-inc/terraform-aws-s3.git?ref=v1.1.0"

  bucket_prefix = "${var.aws_resource_name_prefix}${each.value.prefix}"
}

// Create a ConfigMap per managed bucket for this app
resource "kubernetes_config_map" "managed_buckets" {
  for_each = data.aws_s3_bucket.managed_buckets

  metadata {
    name      = "${var.app_name}-bucket-${each.key}"
    namespace = var.namespace
  }

  data = {
    "BUCKET__${each.key}__arn"  = each.value.arn
    "BUCKET__${each.key}__name" = each.value.bucket
  }
}

// Find ConfigMaps for each bucket owned by other apps
data "kubernetes_config_map" "existing_buckets" {
  for_each = local.existing_map

  metadata {
    name      = "${each.value.project_name}-bucket-${each.key}"
    namespace = each.value.project_group
  }
}

// Create a copy of the bucket configuration of another app for this app
resource "kubernetes_config_map" "existing_buckets" {
  for_each = data.kubernetes_config_map.existing_buckets

  metadata {
    name      = "${var.app_name}-bucketref-${each.key}"
    namespace = var.namespace
  }

  data = each.value.data
}

data "aws_s3_bucket" "managed_buckets" {
  for_each = module.buckets
  bucket   = each.value.bucket_name
}

data "aws_iam_policy_document" "policies" {
  for_each = {
    for label, configmap in local.all_config_maps : "s3-${label}" => configmap.data
  }

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

    resources = [
      each.value["BUCKET__${label}__arn"],
      "${each.value["BUCKET__${label}__arn"]}/*"
    ]
  }
}
