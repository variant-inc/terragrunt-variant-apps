variable "name" {
  type = string
}

variable "chart_values" {
  type = list(string)
}

variable "aws_resource_name_prefix" {
  type = string
}

variable "namespace" {
  type = string
}

variable "policies" {
  type        = list(object)
  description = "Policy documents to be applied inline for the API role"
}
