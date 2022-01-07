resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.namespace
    labels = {
      "istio-injection" : "enabled"
    }
  }
}

data "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 0 : 1
  metadata {
    name = var.namespace
  }
}
