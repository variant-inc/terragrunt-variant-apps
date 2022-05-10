locals {
  dynamodb_managed_map = { for dynamo in var.managed : dynamo.name => dynamo }
}



module "dynamodb_table" {
  source                   = "github.com/variant-inc/terraform-aws-dynamodb.git?ref=v1.2.0"
  for_each                 = local.dynamodb_managed_map
  table_name               = "${var.aws_resource_name_prefix}${each.key}"
  billing_mode             = lookup(each.value, "billing_mode", "PAY_PER_REQUEST")
  hash_key                 = lookup(each.value, "hash_key", null)
  range_key                = lookup(each.value, "range_key", null)
  attributes               = lookup(each.value, "attributes", null)
  global_secondary_indexes = lookup(each.value, "global_secondary_indexes", null)
  local_secondary_indexes  = lookup(each.value, "local_secondary_indexes", null)
  read_capacity            = lookup(each.value, "read_capacity", null)
  write_capacity           = lookup(each.value, "write_capacity", null)
  tags                     = lookup(each.value, "tags", {})
}

#Create a ConfigMap per dynamodb for this app
resource "kubernetes_config_map" "managed" {
  for_each = local.dynamodb_managed_map

  metadata {
    name      = "${var.app_name}-dynamodb-${each.key}"
    namespace = var.namespace
  }

  data = {
    "DYNAMODB__${each.value["reference"]}__arn"  = module.dynamodb_table[each.key].dynamo_db_table_arn
    "DYNAMODB__${each.value["reference"]}__name" = module.dynamodb_table[each.key].dynamo_db_table.name
    "DYNAMODB__${each.key}"                      = module.dynamodb_table[each.key].dynamo_db_table.name
  }
}

# Create a read/write policy for the managed dynamo db table
data "aws_iam_policy_document" "managed" {
  count = length(var.managed) > 0 ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["dynamodb:*"]

    resources = flatten([for k, v in module.dynamodb_table : [
      v.dynamo_db_table_arn,
      "${v.dynamo_db_table_arn}/*"
      ]
    ])
  }
}
