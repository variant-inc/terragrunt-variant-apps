variable "managed" {
  description = "Buckets to be created and managed by terragrunt"
  type        = any
  default     = []
  validation {
    condition     = length([for k, v in var.managed : true if contains(keys(v), "prefix") && contains(keys(v), "reference")]) == length(var.managed)
    error_message = "Each bucket must include prefix and reference."
  }
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

variable "labels" {
  description = "Map of Labels to be applied to config maps"
  type        = map(string)
}
