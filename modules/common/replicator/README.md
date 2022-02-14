<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.69.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.7.1 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table_item.iaac_replicator](https://registry.terraform.io/providers/hashicorp/aws/3.69.0/docs/resources/dynamodb_table_item) | resource |
| [kubernetes_config_map.iaac_replicator](https://registry.terraform.io/providers/hashicorp/kubernetes/2.7.1/docs/resources/config_map) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.7.1/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_release_data"></a> [release\_data](#input\_release\_data) | n/a | <pre>object({<br>    space             = string<br>    project           = string<br>    repository        = string<br>    user              = string<br>    version           = string<br>    image             = string<br>    is_infrastructure = bool<br>  })</pre> | n/a | yes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->