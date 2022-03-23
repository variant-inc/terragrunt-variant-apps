## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.66.0 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | >=1.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.66.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | github.com/variant-inc/terraform-postgres-database | v1 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret_version.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"variant-dev"` | no |
| <a name="input_create_database"></a> [create\_database](#input\_create\_database) | n/a | `any` | n/a | yes |
| <a name="input_database_count"></a> [database\_count](#input\_database\_count) | n/a | `number` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | n/a | `any` | n/a | yes |
| <a name="input_extensions"></a> [extensions](#input\_extensions) | n/a | `list(string)` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
