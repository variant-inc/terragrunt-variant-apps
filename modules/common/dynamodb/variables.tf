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
  description = "Existing dynamo db needing reference by the app. Accepts the following values as keys in each object:[name, reference, cross_account_arn, read_only], In case of refering table from same account just add key name, Whereas in case of cross account table just add cross_account_arn as shown in sample examples and exclude name"
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
  description = "Map of dynamo db objects. Accepts the following values as keys in each object: [name, reference, billing_mode, hash_key, range_key, attributes, global_secondary_indexes, local_secondary_indexes, read_capacity, write_capacity]"
  type        = any
  default     = []
  validation {
    condition     = length([for k, v in var.managed : true if contains(keys(v), "name") && contains(keys(v), "reference")]) == length(var.managed)
    error_message = "Each dynamo db must include name and reference."
  }
}