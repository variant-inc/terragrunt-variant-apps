variable "bucket_config" {
  type = object({
    env = string
    create = list(object({
      prefix = string
    }))
    lookup = list(object({
      name = string
    }))
  })
  default = {
    env    = "non-prod"
    create = []
    lookup = []
  }
}
