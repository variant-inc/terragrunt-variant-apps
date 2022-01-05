locals {
  all_buckets = concat(
    [for idx, b in data.aws_s3_bucket.existing_buckets : {
      id                 = var.bucket_config.existing[idx].id
      domain             = b.bucket_domain_name
      arn                = b.arn
      name               = b.bucket
      externally_managed = true
    }],
    [for idx, b in data.aws_s3_bucket.managed_buckets : {
      id                 = var.bucket_config.managed[idx].id
      domain             = b.bucket_domain_name
      arn                = b.arn
      name               = b.bucket
      externally_managed = false
    }]
  )
  chart_values = yamlencode({
    deployment = {
      envVars = [for b in local.all_buckets : {
        name  = "VARIANT_BUCKET_${b.id}"
        value = jsonencode(b)
      }]
    }
  })
}

module "buckets" {
  count  = length(var.bucket_config.managed)
  source = "github.com/variant-inc/terraform-aws-s3.git?ref=master"

  bucket_prefix = "${var.aws_resource_name_prefix}-${var.bucket_config.managed[count.index].name}"
}

data "aws_s3_bucket" "existing_buckets" {
  count  = length(var.bucket_config.existing)
  bucket = var.bucket_config.existing[count.index].name
}

data "aws_s3_bucket" "managed_buckets" {
  count  = length(module.buckets)
  bucket = module.buckets[count.index].bucket_name
}

data "aws_iam_policy_document" "policies" {
  for_each = local.all_buckets

  policy_id = "s3-${each.value.name}"
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
