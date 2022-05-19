# Terraform Dynamo DB
<!-- markdownlint-disable MD033 MD013 MD041 -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamodb_table"></a> [dynamodb\_table](#module\_dynamodb\_table) | github.com/variant-inc/terraform-aws-dynamodb.git | v1.2 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.existing_cross_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.managed](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [aws_iam_policy_document.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of the app | `string` | n/a | yes |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | Prefix of team name to be applied to created resources. | `string` | n/a | yes |
| <a name="input_existing"></a> [existing](#input\_existing) | Existing dynamo db needing reference by the app. Accepts the following values as keys in each object:[name, reference, cross\_account\_arn, read\_only], In case of refering table from same account just add key name, Whereas in case of cross account table just add cross\_account\_arn as shown in sample examples and exclude name | <pre>list(object(<br>    {<br>      name              = optional(string)<br>      reference         = optional(string)<br>      cross_account_arn = optional(string)<br>      read_only         = optional(bool)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_managed"></a> [managed](#input\_managed) | Map of dynamo db objects. Accepts the following values as keys in each object: [name, reference, billing\_mode, hash\_key, range\_key, attributes, global\_secondary\_indexes, local\_secondary\_indexes, read\_capacity, write\_capacity] | `any` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name of the app | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | Config Maps of Dynamodb |
| <a name="output_policies"></a> [policies](#output\_policies) | Dynamodb Managed and Existing Policies |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->