terraform {
  required_version = "~> 1.1"
  experiments      = [module_variable_optional_attrs]
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

data "aws_iam_policy_document" "role_policies" {
  for_each  = var.policies

  statement {
    actions   = each.value.actions
    effect    = each.value.effect
    resources = each.value.resources
  }
}
