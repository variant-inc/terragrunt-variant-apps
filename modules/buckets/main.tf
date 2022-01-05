locals {
  all_buckets = merge(
    {
      for key, value in data.aws_s3_bucket.existing_buckets : "s3-${key}" => {
        domain             = b.bucket_domain_name
        arn                = b.arn
        name               = b.bucket
        externally_managed = false
      }
    },
    {
      for key, value in data.aws_s3_bucket.managed_buckets : "s3-${key}" => {
        domain             = b.bucket_domain_name
        arn                = b.arn
        name               = b.bucket
        externally_managed = true
      }
  })
  chart_values = yamlencode({
    deployment = {
      envVars = concat(
        [for key, value in local.all_buckets : {
          name  = "VARIANT_BUCKET_${key}_name"
          value = value.name
        }],
        [for key, value in local.all_buckets : {
          name  = "VARIANT_BUCKET_${key}_arn"
          value = value.arn
        }]
      )
    }
  })
}

module "buckets" {
  for_each = var.bucket_config.managed
  source   = "github.com/variant-inc/terraform-aws-s3.git?ref=master"

  bucket_prefix = "${var.aws_resource_name_prefix}-${each.value.name}"
}

data "aws_s3_bucket" "existing_buckets" {
  for_each = var.bucket_config.existing
  bucket   = each.value.name
}

data "aws_s3_bucket" "managed_buckets" {
  for_each = module.buckets
  bucket   = each.value.bucket_name
}

data "aws_iam_policy_document" "policies" {
  for_each = local.all_buckets

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
