output "namespace_name" {
  value = var.namespace
  depends_on = [
    null_resource.create_namespace
  ]
}
