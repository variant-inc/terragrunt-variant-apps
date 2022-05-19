# Terraform S3
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
| <a name="module_buckets"></a> [buckets](#module\_buckets) | github.com/variant-inc/terraform-aws-s3.git | v1.2 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.existing_wo_configmap](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.managed](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [aws_iam_policy_document.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [kubernetes_config_map.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/config_map) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of the app | `string` | n/a | yes |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | Team prefix to prepend to managed buckets | `string` | n/a | yes |
| <a name="input_existing"></a> [existing](#input\_existing) | Existing buckets needing reference by the app | <pre>list(object(<br>    {<br>      full_name     = optional(string)<br>      reference     = optional(string)<br>      read_only     = optional(bool)<br>      project_group = optional(string)<br>      project_name  = optional(string)<br>      bucket_prefix = optional(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_managed"></a> [managed](#input\_managed) | Buckets to be created and managed by terragrunt | `any` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name of the app | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | Config Maps of Buckets |
| <a name="output_policies"></a> [policies](#output\_policies) | Bucket Managed and Existing Policies |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->