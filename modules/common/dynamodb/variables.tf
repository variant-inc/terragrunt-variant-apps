variable "aws_resource_name_prefix" {
  type        = string
  description = "Prefix of team name to be applied to created resources."
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
  description = "Existing dynamo db needing reference by the app"
  type = list(object(
    {
      name              = optional(string)
      reference         = optional(string)
      cross_account_arn = optional(string)
      read_only         = optional(bool)
    }
  ))
  default = []
}

variable "managed" {
  description = "Dynamo db to be created and managed by terragrunt"
  type        = any
  default     = []
  validation {
    condition     = length([for k, v in var.managed : true if contains(keys(v), "name") && contains(keys(v), "reference")]) == length(var.managed)
    error_message = "Each dynamo db must include name and reference."
  }
}