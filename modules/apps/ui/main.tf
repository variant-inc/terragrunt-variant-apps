locals {
  namespace = data.kubernetes_namespace.namespace.metadata[0].name
  service_account_chart_values = [yamlencode({
    serviceAccount = {
      roleArn = var.role_arn
    }
  })]
  final_values = concat(local.service_account_chart_values, var.chart_values)
}

data "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "ui" {
  count             = var.create == true ? 1 : 0
  repository        = "https://variant-inc.github.io/lazy-helm-charts/"
  chart             = "variant-ui"
  name              = var.name
  version           = "~1.4.0"
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

  dynamic "set" {
    for_each = var.tags
    content {
      name  = "tags.${set.key}"
      value = set.value
    }
  }
}
