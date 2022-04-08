<!-- markdownlint-disable MD033 MD013 MD041 -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.iaac_replicator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace of the app | `string` | n/a | yes |
| <a name="input_release_data"></a> [release\_data](#input\_release\_data) | Map of release data | <pre>object({<br>    space             = string<br>    project           = string<br>    repository        = string<br>    user              = string<br>    version           = string<br>    image             = string<br>    is_infrastructure = bool<br>  })</pre> | n/a | yes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->