variable "managed" {
  type = list(object({
    prefix = string
  }))
  default = []
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

variable "existing" {
  type = list(object(
    {
      project_group = string
      project_name  = string
      bucket_prefix = string
    }
  ))
  default = []
}
