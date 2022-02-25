variable "create" {
  type    = bool
  default = false
}

variable "name" {
  type = string
}

variable "chart_values" {
  type = list(string)
}

variable "chart_config_vars" {
  type = list(any)
}

variable "namespace" {
  type = string
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

variable "okta_org_name" {
  type = string
}

variable "okta_base_url" {
  type = string
}

variable "authentication_enabled" {
  type    = bool
  default = false
}

variable "role_arn" {
  type = string
}