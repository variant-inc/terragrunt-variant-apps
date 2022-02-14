variable "managed" {
  type = map(object({
    name = string
  }))
  default = {}
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
