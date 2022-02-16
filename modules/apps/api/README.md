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
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [helm_release.api](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentication_enabled"></a> [authentication\_enabled](#input\_authentication\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_chart_env_vars"></a> [chart\_env\_vars](#input\_chart\_env\_vars) | n/a | `list(any)` | n/a | yes |
| <a name="input_chart_values"></a> [chart\_values](#input\_chart\_values) | n/a | `list(string)` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_okta_base_url"></a> [okta\_base\_url](#input\_okta\_base\_url) | n/a | `string` | n/a | yes |
| <a name="input_okta_org_name"></a> [okta\_org\_name](#input\_okta\_org\_name) | n/a | `string` | n/a | yes |
| <a name="input_policies"></a> [policies](#input\_policies) | Each value in the map should be an aws\_iam\_policy\_document resource | `map(any)` | n/a | yes |
| <a name="input_revision"></a> [revision](#input\_revision) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workload_role_arn"></a> [workload\_role\_arn](#output\_workload\_role\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->