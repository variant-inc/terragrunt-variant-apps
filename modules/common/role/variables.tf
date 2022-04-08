variable "name" {
  type        = string
  description = "Role Name"
}

variable "aws_resource_name_prefix" {
  type        = string
  description = "AWS Resource Name Prefix based on environment"
}

variable "namespace" {
  type        = string
  description = "Namespace of the app"
}

variable "policies" {
  type        = map(any)
  description = "Each value in the map should be an aws_iam_policy_document resource"
}