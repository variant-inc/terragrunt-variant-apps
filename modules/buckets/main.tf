module "buckets" {
  count  = length(var.bucket_config.managed)
  source = "github.com/variant-inc/lazy-terraform//s3?ref=v1"

  region        = data.aws_region.current.name
  bucket_prefix = "${var.aws_resource_name_prefix}-${var.bucket_config.managed[count.index].name}"
  env           = var.bucket_config.env

  octopus_tags = var.octopus_tags
  user_tags    = var.user_tags
}


data "aws_s3_bucket" "buckets" {
  count  = length(var.bucket_config.existing)
  bucket = var.bucket_config.existing[count.index].name
}
