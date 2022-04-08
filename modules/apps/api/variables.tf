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

variable "chart_config_vars" {
  type        = list(any)
  description = "Chart Config Vars"
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

variable "okta_org_name" {
  type        = string
  description = "Okta Organization Name"
}

variable "okta_base_url" {
  type        = string
  description = "Okta Base URL"
}

variable "authentication_enabled" {
  type        = bool
  default     = false
  description = "Boolean value for Authentication"
}

variable "role_arn" {
  type        = string
  description = "Role ARN from apps.hcl"
}