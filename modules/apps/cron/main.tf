terraform {
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
  namespace   = data.kubernetes_namespace.namespace.metadata[0].name
  oidc_issuer = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
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

  final_values = concat(
    local.service_account_chart_values,
    local.chart_config_vars,
    var.chart_values
  )
}

data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "cron" {
  count             = var.create == true ? 1 : 0
  repository        = "https://variant-inc.github.io/lazy-helm-charts/"
  chart             = "variant-cron"
  version           = "1.2.1"
  cleanup_on_fail   = true
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
    name  = "cronJob.image.tag"
    value = var.image
  }

  set {
    name  = "CLUSTER_NAME"
    value = var.cluster_name
  }

  dynamic "set" {
    for_each = var.tags
    content {
      name  = "tags.${set.key}"
      value = set.value
    }
  }
}
