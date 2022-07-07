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

variable "tags" {
  type        = map(string)
  description = "Tags Output from Tags Module"
}

variable "atomic" {
  type        = bool
  description = "If true, sets atomic flag on helm upgrade, if upgrade fails it reverts it"
  default     = true
}

variable "timeout" {
  type        = number
  description = "Timeout for helm upgrade to finish, in seconds, if not set defaults to 600"
  default     = 600
}
