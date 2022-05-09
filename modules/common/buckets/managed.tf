locals {
  # Convert the list of inputs into map where each key is the bucket prefix
  managed_map = { for bucket in var.managed : bucket["prefix"] => bucket }
}

# Create the buckets that are managed and owned by this app
module "buckets" {
  for_each                   = local.managed_map
  source                     = "github.com/variant-inc/terraform-aws-s3.git?ref=v1.2.0"
  bucket_prefix              = "${var.aws_resource_name_prefix}${each.key}"
  tags                       = lookup(each.value, "tags", {})
  lifecycle_rule             = lookup(each.value, "lifecycle_rule", [])
  bucket_policy              = lookup(each.value, "bucket_policy", [])
  enable_bucket_notification = lookup(each.value, "enable_bucket_notification", false)
  force_destroy              = lookup(each.value, "force_destroy", false)
}

# Get the DynamoDB Table for storing bucket info
data "aws_dynamodb_table" "s3_table" {
  name = "iaac_cake_s3"
}

# PUT an item in the DynamoDB Table to store bucket info
resource "aws_dynamodb_table_item" "s3_table" {
  for_each = local.managed_map

  table_name = data.aws_dynamodb_table.s3_table.name
  hash_key   = data.aws_dynamodb_table.s3_table.hash_key
  range_key  = data.aws_dynamodb_table.s3_table.range_key

  item = <<ITEM
{
  "project": {"S": "${var.octopus_space}-${var.namespace}-${var.app_name}"},
  "bucket_prefix": {"S": "${each.key}"},
  "bucket_name": {"S": "${module.buckets[each.key].bucket_name}"},
  "bucket_arn": {"S": "${module.buckets[each.key].bucket_arn}"}
}
ITEM
}

# Create a ConfigMap per managed bucket for this app
resource "kubernetes_config_map" "managed" {
  for_each = local.managed_map

  metadata {
    name      = "${var.app_name}-bucket-${each.key}"
    namespace = var.namespace
  }

  data = {
    "BUCKET__${each.value["reference"]}__arn"  = module.buckets[each.key].bucket_arn
    "BUCKET__${each.value["reference"]}__name" = module.buckets[each.key].bucket_name
    "BUCKET__${each.key}"                      = module.buckets[each.key].bucket_name
  }
}

# Create a read/write policy for the managed buckets
data "aws_iam_policy_document" "managed" {
  count = length(var.managed) > 0 ? 1 : 0

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

    resources = flatten([for k, v in module.buckets : [
      v.bucket_arn,
      "${v.bucket_arn}/*"
      ]
    ])
  }
}
