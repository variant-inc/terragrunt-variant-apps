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

variable "cluster_name" {
  type        = string
  description = "Name of cluster to deploy app into."
}

variable "custom_policy" {
  type        = string
  description = "A string containing an list of actions, an effect and list of resources"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be applied to resources"
}

variable "boundary_extra" {
  type        = any
  description = "Additional boundary policies, use when you need to access resources that have different prefix than your app."
  default     = {}
}
