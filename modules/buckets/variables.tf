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

variable "aws_resource_name_prefix" {
  type = string
}
