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
| [aws_db_instance.physical_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance) | data source |
| [aws_iam_policy_document.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_secretsmanager_secret_version.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster | `string` | `"variant-dev"` | no |
| <a name="input_create_any"></a> [create\_any](#input\_create\_any) | To create database or a role | `bool` | n/a | yes |
| <a name="input_create_database"></a> [create\_database](#input\_create\_database) | Value to create database | `bool` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Name of the database | `string` | n/a | yes |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | Extensions for the database | `list(string)` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Database user name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database"></a> [database](#output\_database) | Name of the Database |
| <a name="output_env_vars"></a> [env\_vars](#output\_env\_vars) | Environment variables for app use. |
| <a name="output_password"></a> [password](#output\_password) | Password of the User |
| <a name="output_policies"></a> [policies](#output\_policies) | n/a |
| <a name="output_user"></a> [user](#output\_user) | Name of the User |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->