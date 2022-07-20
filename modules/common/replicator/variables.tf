variable "release_data" {
  type = object({
    space             = string
    project           = string
    repository        = string
    user              = string
    version           = string
    image             = string
    is_infrastructure = bool
  })
  description = "Map of release data"
}

variable "actions_octopus_version" {
  type        = string
  default     = "v3"
  description = "Actions Octopus version"
}

variable "namespace" {
  type        = string
  description = "Namespace of the app"
}