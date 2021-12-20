resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
    labels = {
      "istio-injection" : "enabled"
    }
  }
}
