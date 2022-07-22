variable "namespace" {
  type        = string
  description = "Kubernetes Namespace"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster to deploy app into."
}