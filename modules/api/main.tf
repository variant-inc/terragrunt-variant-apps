resource "helm_release" "api" {
  repository        = "https://variant-inc.github.io/lazy-helm-charts/"
  chart             = "variant-api"
  version           = "2.0.0-beta1"
  name              = var.name
  namespace         = data.kubernetes_namespace.namespace.metadata[0].name
  lint              = true
  dependency_update = true

  values = var.values
}
