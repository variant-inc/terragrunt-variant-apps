terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
  }
}

locals {
  all_buckets = merge(
    {
      for label, bucket in data.aws_s3_bucket.existing_buckets : label => {
        domain             = bucket.bucket_domain_name
        arn                = bucket.arn
        name               = bucket.bucket
        externally_managed = false
      }
    },
    {
      for label, bucket in data.aws_s3_bucket.managed_buckets : label => {
        domain             = bucket.bucket_domain_name
        arn                = bucket.arn
        name               = bucket.bucket
        externally_managed = true
      }
  })
  env_vars = flatten([for label, bucket in local.all_buckets :
    [
      {
        name  = "BUCKET__${label}__name"
        value = bucket.name
      },
      {
        name  = "BUCKET__${label}__arn"
        value = bucket.arn
      },
      {
        name  = "BUCKET__${label}__domain"
        value = bucket.domain
      }
    ]
  ])
}

module "buckets" {
  for_each = var.managed
  source   = "github.com/variant-inc/terraform-aws-s3.git?ref=v1.1.0"

  bucket_prefix = "${var.aws_resource_name_prefix}${each.value.name}"
}

data "aws_s3_bucket" "existing_buckets" {
  for_each = var.existing
  bucket   = each.value.name
}

data "aws_s3_bucket" "managed_buckets" {
  for_each = module.buckets
  bucket   = each.value.bucket_name
}

data "aws_iam_policy_document" "policies" {
  for_each = {
    for label, bucket in local.all_buckets : "s3-${label}" => bucket
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
      each.value.arn,
      "${each.value.arn}/*"
    ]
  }
}
