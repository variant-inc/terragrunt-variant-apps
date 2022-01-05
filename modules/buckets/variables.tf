variable "bucket_config" {
  type = map({
    managed = map({
      name = string
    })
    existing = map({
      name = string
    })
  })
  default = {
    managed  = {}
    existing = {}
  }
}

variable "aws_resource_name_prefix" {
  type = string
}
