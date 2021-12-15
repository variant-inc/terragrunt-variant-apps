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
  source = "github.com/variant-inc/lazy-terraform//s3?ref=v1"

  region        = data.aws_region.current.name
  bucket_prefix = "${var.aws_resource_name_prefix}-${var.bucket_config.managed[count.index].name}"
  env           = var.bucket_config.env

  octopus_tags = var.octopus_tags
  user_tags    = var.user_tags
}

data "aws_s3_bucket" "existing_buckets" {
  count  = length(var.bucket_config.existing)
  bucket = var.bucket_config.existing[count.index].name
}

data "aws_s3_bucket" "managed_buckets" {
  count  = length(module.buckets)
  bucket = module.buckets[count.index].bucket_name
}
