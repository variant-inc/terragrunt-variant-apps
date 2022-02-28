<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |

## Resources

| Name | Type |
|------|------|
| [helm_release.handler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_config_vars"></a> [chart\_config\_vars](#input\_chart\_config\_vars) | n/a | `list(any)` | n/a | yes |
| <a name="input_chart_values"></a> [chart\_values](#input\_chart\_values) | n/a | `list(string)` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | n/a | `bool` | `false` | no |
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_revision"></a> [revision](#input\_revision) | n/a | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->