<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_buckets"></a> [buckets](#module\_buckets) | github.com/variant-inc/terraform-aws-s3.git | v1.1.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.managed](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [aws_iam_policy_document.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_s3_bucket.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [kubernetes_config_map.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/config_map) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of app | `string` | n/a | yes |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_existing"></a> [existing](#input\_existing) | n/a | <pre>list(object(<br>    {<br>      project_group = string<br>      project_name  = string<br>      bucket_prefix = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_managed"></a> [managed](#input\_managed) | n/a | <pre>list(object({<br>    prefix = string<br>  }))</pre> | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | n/a |
| <a name="output_policies"></a> [policies](#output\_policies) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->