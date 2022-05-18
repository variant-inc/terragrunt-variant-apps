include "root" {
  path = find_in_parent_folders()
}

locals {
  deploy_yaml = read_terragrunt_config(find_in_parent_folders()).locals.deploy_yaml
}

terraform {
  source = "github.com/variant-inc/lazy-terraform//submodules/tags?ref=v1.9.0"
}

inputs = {
  user_tags = {
    owner   = coalesce("#{owner}", try(local.deploy_yaml.tags.owner, ""))
    team    = coalesce("#{team}", try(local.deploy_yaml.tags.team, ""))
    purpose = coalesce("#{purpose}", try(local.deploy_yaml.tags.purpose, "Default Purpose"))
  }
}