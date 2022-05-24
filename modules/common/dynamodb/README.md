# Terraform Dynamo DB

## DX Inputs
<!-- markdownlint-disable MD033 MD013 MD041 -->
### Managed

| Key                      | Type                                                      | Default         | Description                                                                            | Example                                                                                                                                     | Required |
| ------------------------ | --------------------------------------------------------- | --------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| name                     | string                                                    |                 | Name of the table to be created                                                        | hello                                                                                                                                       | yes      |
| reference                | string                                                    |                 | Short name to refer the table                                                          | hw                                                                                                                                          | yes      |
| billing_mode             | string                                                    | PAY_PER_REQUEST | Controls how you are charged for read and write throughput and how you manage capacity | PAY_PER_REQUEST                                                                                                                             | optional |
| hash_key                 | string                                                    |                 | The attribute to use as the hash (partition) key                                       | UserId                                                                                                                                      | yes      |
| range_key                | string                                                    | null            | The attribute to use as the range (sort) key                                           | Name                                                                                                                                        | optional |
| attributes               | list ( object ({ name  =   string , type  =   string  })) | null            | List of nested attribute definitions.                                                  | [Docs]([#aws-docs](https://github.com/variant-inc/terraform-aws-dynamodb/blob/master/examples/vars/terraform-example-detailed.tfvars.json)) | optional |
| global_secondary_indexes | any                                                       | null            | GSI for the table                                                                      | [Docs](https://github.com/variant-inc/terraform-aws-dynamodb/blob/master/examples/vars/terraform-example-detailed.tfvars.json)              | optional |
| local_secondary_indexes  | any                                                       | null            | LSI on the table                                                                       | [Docs](https://github.com/variant-inc/terraform-aws-dynamodb/blob/master/examples/vars/terraform-example-detailed.tfvars.json)              | optional |
| read_capacity            | number                                                    | 2               | The number of read units for this table                                                | 2                                                                                                                                           | optional |
| write_capacity           | number                                                    | 2               | The number of write units for this table                                               | 2                                                                                                                                           | optional |

#### AWS Docs

- [Amazon Dynamo DB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.TablesItemsAttributes)

### Existing

| Key       | Type    | Default | Description                                              | Example                                         | Required |
| --------- | ------- | ------- | -------------------------------------------------------- | ----------------------------------------------- | -------- |
| name      | string  |         | Name of the table to be referenced by the app            | hello                                           | yes      |
| reference | string  |         | Short name reference for the table                       | hw                                              | yes      |
| arn       | string  |         | Arn of the same account or cross account dynamo db table | arn:aws:dynamodb:us-east-1:123456789:table/test | optional |
| read_only | boolean |         | Permissions to be assigned to the app role               | true                                            | optional |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name                                                                         | Version |
| ---------------------------------------------------------------------------- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)    | ~> 1.1  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                      | ~> 3.74 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8  |

## Modules

| Name                                                                             | Source                                            | Version |
| -------------------------------------------------------------------------------- | ------------------------------------------------- | ------- |
| <a name="module_dynamodb_table"></a> [dynamodb\_table](#module\_dynamodb\_table) | github.com/variant-inc/terraform-aws-dynamodb.git | v1.2.0  |

## Resources

| Name                                                                                                                                          | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [kubernetes_config_map.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map)               | resource    |
| [kubernetes_config_map.existing_cross_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource    |
| [kubernetes_config_map.managed](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map)                | resource    |
| [aws_iam_policy_document.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)        | data source |
| [aws_iam_policy_document.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)         | data source |

## Inputs

| Name                                                                                                             | Description                                                                                                                                                                                                                                                                                                                              | Type                                                                                                                                                                                                                                    | Default | Required |
| ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name)                                                     | Release name of the app                                                                                                                                                                                                                                                                                                                  | `string`                                                                                                                                                                                                                                | n/a     |   yes    |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | Prefix of team name to be applied to created resources.                                                                                                                                                                                                                                                                                  | `string`                                                                                                                                                                                                                                | n/a     |   yes    |
| <a name="input_existing"></a> [existing](#input\_existing)                                                       | Existing dynamo db needing reference by the app. Accepts the following values as keys in each object:[name, reference, cross\_account\_arn, read\_only], In case of refering table from same account just add key name, Whereas in case of cross account table just add cross\_account\_arn as shown in sample examples and exclude name | <pre>list(object(<br>    {<br>      name              = optional(string)<br>      reference         = optional(string)<br>      cross_account_arn = optional(string)<br>      read_only         = optional(bool)<br>    }<br>  ))</pre> | `[]`    |    no    |
| <a name="input_managed"></a> [managed](#input\_managed)                                                          | Map of dynamo db objects. Accepts the following values as keys in each object: [name, reference, billing\_mode, hash\_key, range\_key, attributes, global\_secondary\_indexes, local\_secondary\_indexes, read\_capacity, write\_capacity]                                                                                               | `any`                                                                                                                                                                                                                                   | `[]`    |    no    |
| <a name="input_namespace"></a> [namespace](#input\_namespace)                                                    | Namespace name of the app                                                                                                                                                                                                                                                                                                                | `string`                                                                                                                                                                                                                                | n/a     |   yes    |

## Outputs

| Name                                                                    | Description                            |
| ----------------------------------------------------------------------- | -------------------------------------- |
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | Config Maps of Dynamodb                |
| <a name="output_policies"></a> [policies](#output\_policies)            | Dynamodb Managed and Existing Policies |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->