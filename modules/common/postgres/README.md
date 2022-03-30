<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.66 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.14 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_database"></a> [database](#module\_database) | github.com/variant-inc/terraform-postgres-database | v1 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.postgres](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [aws_db_instance.physical_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance) | data source |
| [aws_iam_policy_document.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_secretsmanager_secret_version.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of the app | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name of the app | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_OIUGFITUYQVBLJKHFUDYRSTDUTFIGHOIJHUIOGYUFTYD"></a> [OIUGFITUYQVBLJKHFUDYRSTDUTFIGHOIJHUIOGYUFTYD](#output\_OIUGFITUYQVBLJKHFUDYRSTDUTFIGHOIJHUIOGYUFTYD) | n/a |
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | n/a |
| <a name="output_policy"></a> [policy](#output\_policy) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
