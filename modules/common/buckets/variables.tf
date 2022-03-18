variable "managed" {
  description = "Buckets to be created and managed by terragrunt"
  type = list(object({
    prefix = string
  }))
  default = []
}

variable "aws_resource_name_prefix" {
  description = "Team prefix to prepend to managed buckets"
  type        = string
}

variable "app_name" {
  type        = string
  description = "Release name of the app"
}

variable "namespace" {
  description = "Namespace name of the app"
  type        = string
}

variable "existing" {
  description = "Existing buckets needing reference by the app"
  type = list(object(
    {
      full_name     = optional(string)
      reference     = optional(string)
      read_only     = optional(bool)
      project_group = optional(string)
      project_name  = optional(string)
      bucket_prefix = optional(string)
    }
  ))
  default = []
}
