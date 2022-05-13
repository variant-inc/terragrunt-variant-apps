terraform {
  required_version = "~> 1.1"
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
  policies_map = yamldecode(var.policies)
}

data "aws_iam_policy_document" "role_policies" {
  for_each  = local.policies_map

  statement {
    actions   = each.value.actions
    effect    = each.value.effect
    resources = each.value.resources
  }
}
