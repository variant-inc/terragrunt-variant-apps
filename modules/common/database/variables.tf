variable "create_database" {
  type        = bool
  description = "Value to create database"
}

variable "db_name" {
  type        = string
  description = "Name of the database"
}

variable "extensions" {
  type        = list(string)
  description = "Extensions for the database"
}

variable "role_name" {
  type        = string
  description = "Database user name "
}

variable "cluster_name" {
  type        = string
  default     = "variant-dev"
  description = "Name of the cluster"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}