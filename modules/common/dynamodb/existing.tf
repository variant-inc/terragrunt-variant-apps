locals {
  # Convert the list of inputs into map where each key is the bucket prefix
  dynamodb_existing_map           = { for existing in var.existing : existing.name => defaults(existing, { read_only = true }) if existing.name != null }
  dynamodb_arn_existing_map = { for existing in var.existing : existing.reference => defaults(existing, { read_only = true }) if existing.arn != null }
}

resource "kubernetes_config_map" "existing_arn" {
  for_each = local.dynamodb_arn_existing_map

  metadata {
    name      = "${var.app_name}-dynamodb-arn-${local.dynamodb_arn_existing_map[each.key].reference}"
    namespace = var.namespace
  }

  data = {
    "DYNAMODB__${local.dynamodb_arn_existing_map[each.key].reference}__arn" = "${each.value.arn}"
  }
}

resource "kubernetes_config_map" "existing" {
  for_each = local.dynamodb_existing_map

  metadata {
    name      = "${var.app_name}-dynamodb-${replace(each.key, "_", "-")}"
    namespace = var.namespace
  }

  data = {
    "DYNAMODB__${each.value["reference"]}__arn"  = "arn:aws:dynamodb:::table/${each.value.name}"
    "DYNAMODB__${each.value["reference"]}__name" = each.value.name
  }
}

locals {
  read_only_policy = [
    "dynamodb:GetItem",
    "dynamodb:BatchGetItem",
    "dynamodb:Scan",
    "dynamodb:Query",
    "dynamodb:DescribeTable",
    "dynamodb:ConditionCheckItem"
  ]

  rw_policy = [
    "dynamodb:BatchGetItem",
    "dynamodb:BatchWriteItem",
    "dynamodb:ConditionCheckItem",
    "dynamodb:PutItem",
    "dynamodb:DescribeTable",
    "dynamodb:DeleteItem",
    "dynamodb:GetItem",
    "dynamodb:Scan",
    "dynamodb:Query",
    "dynamodb:UpdateItem"
  ]
}
# Create a read policy for the existing dynamodb
data "aws_iam_policy_document" "existing" {
  count = length(var.existing) > 0 ? 1 : 0

  dynamic "statement" {
    for_each = local.dynamodb_existing_map
    content {
      effect  = "Allow"
      actions = statement.value.read_only ? local.read_only_policy : local.rw_policy
      resources = [
        "arn:aws:dynamodb:::table/${statement.value.name}",
        "arn:aws:dynamodb:::table/${statement.value.name}/*"
      ]
    }
  }

  dynamic "statement" {
    for_each = local.dynamodb_arn_existing_map
    content {
      effect  = "Allow"
      actions = statement.value.read_only ? local.read_only_policy : local.rw_policy
      resources = [
        "${statement.value.arn}",
        "${statement.value.arn}/*"
      ]
    }
  }
}
