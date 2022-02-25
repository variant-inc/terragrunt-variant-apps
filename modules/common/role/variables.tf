variable "name" {
  type = string
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