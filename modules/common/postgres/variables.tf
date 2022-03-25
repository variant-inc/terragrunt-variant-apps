variable "databases" {
  type = any
  description = "List of Postgres Databases to create. [ name, reference, role_name, read_only (Optional: false), extensions (Optional: []) ]"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "app_name" {
  type        = string
  description = "Release name of the app"
}

variable "namespace" {
  description = "Namespace name of the app"
  type        = string
}
