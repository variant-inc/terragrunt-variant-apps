resource "null_resource" "create_namespace" {
  provisioner "local-exec" {
    working_dir = path.module
    command     = "chmod +x ./create_namespace.sh && ./create_namespace.sh ${var.cluster_name} ${var.namespace}"
  }
}
