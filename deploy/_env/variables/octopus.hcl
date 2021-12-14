generate "variables_octopus" {
  path      = "variables_octopus.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "octopus_tags" {
  type = map(string)
}

variable "user_tags" {
  type = map(string)
}

EOF
}
