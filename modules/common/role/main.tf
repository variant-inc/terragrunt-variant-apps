locals {
  namespace   = data.kubernetes_namespace.namespace.metadata[0].name
  oidc_issuer = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")

  boundary_name     = "${var.aws_resource_name_prefix}${var.name}-boundaryPolicy"
  infra_policy_json = [for k, v in var.policies : v.json]
}

data "aws_caller_identity" "current" {}

data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_issuer}"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "${local.oidc_issuer}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "${local.oidc_issuer}:sub"
      values   = ["system:serviceaccount:${local.namespace}:${var.name}"]
    }
  }
}

data "aws_iam_policy_document" "boundary_source" {
  dynamic "statement" {
    for_each = var.boundary_extra
    content {
      sid       = statement.key
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }

  statement {
    sid    = "DenyTFState"
    effect = "Deny"
    actions = [
      "s3:put*",
      "s3:delete*"
    ]
    resources = [
      "arn:aws:s3:::*tf-state*"
    ]
  }
  statement {
    sid    = "PrefixAllow"
    effect = "Allow"
    actions = [
      "*"
    ]
    resources = [
      "arn:aws:s3:::*${var.aws_resource_name_prefix}*",
      "arn:aws:dynamodb:*:*:table/*${var.aws_resource_name_prefix}*",
      "arn:aws:logs:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:elasticache:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:kms:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:rds:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:secretsmanager:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:sns:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:sqs:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:ec2:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:mq:*:*:*${var.aws_resource_name_prefix}*",
      "arn:aws:iam::*:policy/*${var.aws_resource_name_prefix}*",
      "arn:aws:iam::*:role/*${var.aws_resource_name_prefix}*",
      "arn:aws:iam::*:user/*${var.aws_resource_name_prefix}*"
    ]
  }
  statement {
    sid    = "listallow"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "logs:Create*",
      "logs:Describe*",
      "logs:List*",
      "elasticache:Create*",
      "elasticache:DescribeCacheClusters",
      "sts:AssumeRole",
      "sts:TagSession",
      "iam:List*",
      "iam:Get*",
      "kms:ListKeys",
      "rds:DescribeDBClusters",
      "secretsmanager:ListSecrets",
      "sns:ListTopics",
      "sqs:ListQueues",
      "ec2:Describe*",
      "mq:List*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "NoBoundaryPolicyEdit"
    effect = "Deny"
    actions = [
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion"
    ]
    resources = [
      "arn:aws:iam::*:policy/${local.boundary_name}"
    ]
  }
  statement {
    sid    = "NoBoundaryDelete"
    effect = "Deny"
    actions = [
      "iam:DeleteRolePermissionsBoundary"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "boundary_policy" {
  source_policy_documents = concat(
    [data.aws_iam_policy_document.boundary_source.json],
    local.infra_policy_json
  )
}

resource "aws_iam_policy" "boundary_policy" {
  name        = local.boundary_name
  description = "Boundary policy used for roles created by DX"

  policy = data.aws_iam_policy_document.boundary_policy.json
}

resource "aws_iam_role" "role" {
  name                  = "${var.aws_resource_name_prefix}${var.name}"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  permissions_boundary  = aws_iam_policy.boundary_policy.arn

  dynamic "inline_policy" {
    for_each = var.policies
    content {
      name   = inline_policy.key
      policy = replace(inline_policy.value.json, "\n", "")
    }
  }

  inline_policy {
    name   = "custom_policy"
    policy = trimspace(var.custom_policy)
  }

}
