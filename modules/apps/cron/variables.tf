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

variable "image" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "tags" {
  type = map(string)
}
