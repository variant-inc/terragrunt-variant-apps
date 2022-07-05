variable "create" {
  type        = bool
  default     = false
  description = "Boolean Value for Create"
}

variable "name" {
  type        = string
  description = "Octopus Project Name"
}

variable "chart_values" {
  type        = list(string)
  description = "Chart values"
}

variable "namespace" {
  type        = string
  description = "Octopus ProjectGroup Name"
}

variable "revision" {
  type        = string
  description = "Octopus Release Number"
}

variable "domain" {
  type        = string
  description = "Domain"
}

variable "image" {
  type        = string
  description = "Deploy YAML git Image"
}

variable "role_arn" {
  type        = string
  description = "Role ARN from apps.hcl"
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster to deploy app into."
}

variable "tags" {
  type        = map(string)
  description = "Tags Output from Tags Module"
}