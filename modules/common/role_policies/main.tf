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

resource "aws_iam_policy_document" "role_policies" {
  for_each  = var.policies

  actions   = each.actions
  effect    = each.effect
  resources = each.resources
}
