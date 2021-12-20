output "namespace_name" {
  value = kubernetes_namespace.namespace.metadata[0].name
}
