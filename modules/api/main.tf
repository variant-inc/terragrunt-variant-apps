terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.69.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}

locals {
  namespace   = data.kubernetes_namespace.namespace.metadata[0].name
  oidc_issuer = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
  service_account_chart_values = [yamlencode({
    serviceAccount = {
      roleArn = aws_iam_role.role.arn
    }
  })]
  final_values     = concat(local.service_account_chart_values, var.chart_values)
  oauth_server_url = "https://${var.okta_provider_config.org_name}.${var.okta_provider_config.base_url}/oauth2/default"
}

data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "api" {
  repository        = "https://variant-inc.github.io/lazy-helm-charts/"
  chart             = "variant-api"
  version           = "2.0.0-beta3"
  name              = var.name
  namespace         = local.namespace
  lint              = true
  dependency_update = true

  values = local.final_values

  set {
    name  = "revision"
    value = var.revision
  }

  set {
    name  = "istio.ingress.host"
    value = var.domain
  }

  set {
    name  = "deployment.image.tag"
    value = var.image
  }

  set {
    name  = "authentication.enabled"
    value = var.authentication_enabled
  }

  set {
    name  = "authentication.server"
    value = local.oauth_server_url
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
  name                  = "${var.aws_resource_name_prefix}-${var.name}"
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
