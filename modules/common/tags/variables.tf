variable "name" {
  type        = string
  description = "Name of your deployment."
}

variable "user_tags" {
  type        = map(any)
  description = "User defined tags. Should include keys of [ \"team\", \"owner\", \"purpose\" ]."
}

variable "octopus_tags" {
  type        = map(any)
  description = "Octopus defined tags. Managed by Cloudops."
}