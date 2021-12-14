module "buckets" {
  count  = length(var.bucket_config.create)
  source = "github.com/variant-inc/lazy-terraform//s3?ref=v1"

  region        = data.aws_region.current.name
  bucket_prefix = var.bucket_config.create[count.index].prefix
  env           = var.bucket_config.env

  octopus_tags = var.octopus_tags
  user_tags    = var.user_tags
}


