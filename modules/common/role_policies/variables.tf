variable "policies" {
  type        = list(object(
    {
      actions = optional(list(string))
      effect  = optional(string)
      resources = optional(list(string))
    }
  ))
  default     = []
  description = "A map containing an array of actions, an effect and array of resources"
}
