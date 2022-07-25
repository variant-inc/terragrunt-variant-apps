variable "databases" {
  type        = any
  description = "List of Postgres Databases to create. [ name, reference, role_name, read_only (Optional: false), extensions (Optional: []) ]"
}

variable "app_name" {
  type        = string
  description = "Release name of the app"
}
# 
# variable "namespace" {
#   type        = string
#   description = "Namespace name of the app"
# }

# variable "labels" {
#   description = "Map of Labels to be applied to config maps"
#   type        = map(string)
# }
