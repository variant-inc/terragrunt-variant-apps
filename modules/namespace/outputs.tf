output "namespace_name" {
  value = var.create_namespace ? kubernetes_namespace.namespace[0].metadata[0].name : data.kubernetes_namespace.namespace[0].metadata[0].name
}
