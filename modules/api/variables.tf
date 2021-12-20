variable "name" {
  type = string
}

variable "chart_values" {
  type = list(string)
}

variable "aws_resource_name_prefix" {
  type = string
}
