variable "postgres" {
  type        = any
  description = "List of Postgres Databases to create. [ name, reference, role_name, read_only (Optional: false), extensions (Optional: []) ]"
}

variable "app_name" {
  type        = string
  description = "Release name of the app"
}

variable "namespace" {
  type        = string
  description = "Namespace name of the app"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster to deploy app into."
}

variable "tags" {
  type        = map(any)
  description = "Tags to be applied to resources"
}
variable "labels" {
  description = "Map of Labels to be applied to config maps"
  type        = map(string)
}
