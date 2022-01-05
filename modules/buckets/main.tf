locals {
  all_buckets = merge(
    {
      for label, bucket in data.aws_s3_bucket.existing_buckets : "s3-${label}" => {
        domain             = bucket.bucket_domain_name
        arn                = bucket.arn
        name               = bucket.bucket
        externally_managed = false
      }
    },
    {
      for label, bucket in data.aws_s3_bucket.managed_buckets : "s3-${label}" => {
        domain             = bucket.bucket_domain_name
        arn                = bucket.arn
        name               = bucket.bucket
        externally_managed = true
      }
  })
  chart_values = yamlencode({
    deployment = {
      envVars = concat(
        [for label, bucket in local.all_buckets : {
          name  = "VARIANT_BUCKET_${label}_name"
          value = bucket.name
        }],
        [for label, bucket in local.all_buckets : {
          name  = "VARIANT_BUCKET_${label}_arn"
          value = bucket.arn
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
