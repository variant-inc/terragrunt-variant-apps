variable "database_count" {
  type = number
}

variable "create_database" {}

variable "database_name" {}

variable "extensions" {
  type = list(string)
}

variable "role_name" {}

variable "cluster_name" {
  default = "variant-dev"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}