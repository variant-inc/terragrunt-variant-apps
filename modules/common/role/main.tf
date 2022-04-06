terraform {
  required_version = "~>1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8"
    }
  }
}

locals {
  namespace   = data.kubernetes_namespace.namespace.metadata[0].name
  oidc_issuer = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")

}

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

resource "aws_iam_role" "role" {
  name                  = "${var.aws_resource_name_prefix}${var.name}"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json

  dynamic "inline_policy" {
    for_each = var.policies
    content {
      name   = inline_policy.key
      policy = inline_policy.value.json
    }
  }
}
