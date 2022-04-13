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
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4"
    }
  }
}

locals {
  namespace = data.kubernetes_namespace.namespace.metadata[0].name
  chart_config_vars = [yamlencode({
    configVars = {
      for v in var.chart_config_vars : v.name => v.value
    }
  })]
  service_account_chart_values = [yamlencode({
    serviceAccount = {
      roleArn = var.role_arn
    }
  })]
  final_values     = concat(local.service_account_chart_values, local.chart_config_vars, var.chart_values)
  oauth_server_url = "https://${var.okta_org_name}.${var.okta_base_url}/oauth2/default"
}

data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "api" {
  count             = var.create == true ? 1 : 0
  repository        = "https://variant-inc.github.io/lazy-helm-charts/"
  chart             = "variant-api"
  name              = var.name
  version           = "~2.1.0"
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
