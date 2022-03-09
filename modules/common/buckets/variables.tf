variable "managed" {
  type = list(object({
    prefix = string
  }))
  default = []
}

variable "existing" {
  type = map(object({
    name = string
  }))
  default = {}
}

variable "aws_resource_name_prefix" {
  type = string
}

variable "app_name" {
  type        = string
  description = "Release name of app"
}

variable "namespace" {
  type = string
}
