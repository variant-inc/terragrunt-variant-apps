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
}

variable "namespace" {
  type = string
}