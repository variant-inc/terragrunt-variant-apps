module "tags" {
  source       = "github.com/variant-inc/lazy-terraform//submodules/tags?ref=v1"
  user_tags    = var.user_tags
  name         = var.name
  octopus_tags = var.octopus_tags
}