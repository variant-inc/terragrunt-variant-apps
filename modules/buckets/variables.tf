variable "bucket_config" {
  type = object({
    managed = map(object({
      name = string
    }))
    existing = map(object({
      name = string
    }))
  })
  default = {
    managed  = {}
    existing = {}
  }
}

variable "aws_resource_name_prefix" {
  type = string
}
