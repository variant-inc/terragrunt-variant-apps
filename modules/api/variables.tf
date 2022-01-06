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
  type        = map(any)
  description = "Each value in the map should be an aws_iam_policy_document resource"
}

variable "revision" {
  type = string
}

variable "domain" {
  type = string
}

variable "image" {
  type = string
}
