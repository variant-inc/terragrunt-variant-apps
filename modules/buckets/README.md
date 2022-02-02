<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_buckets"></a> [buckets](#module\_buckets) | github.com/variant-inc/terraform-aws-s3.git | master |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_s3_bucket.existing_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [aws_s3_bucket.managed_buckets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_existing"></a> [existing](#input\_existing) | n/a | <pre>map(object({<br>    name = string<br>  }))</pre> | `{}` | no |
| <a name="input_managed"></a> [managed](#input\_managed) | n/a | <pre>map(object({<br>    name = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_buckets"></a> [all\_buckets](#output\_all\_buckets) | n/a |
| <a name="output_chart_values"></a> [chart\_values](#output\_chart\_values) | n/a |
| <a name="output_policies"></a> [policies](#output\_policies) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->