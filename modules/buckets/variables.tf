variable "bucket_config" {
  type = object({
    env = string
    managed = list(object({
      id   = string
      name = string
    }))
    existing = list(object({
      id   = string
      name = string
    }))
  })
  default = {
    env      = "non-prod"
    managed  = []
    existing = []
  }
}

variable "octopus_tags" {
  type = map(string)
}

variable "user_tags" {
  type = map(string)
}

variable "aws_resource_name_prefix" {
  type = string
}
