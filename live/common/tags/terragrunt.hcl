include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/variant-inc/lazy-terraform//submodules/tags?ref=v1"
}
