# Terraform S3

## DX Inputs

<!-- markdownlint-disable MD033 MD013 MD041 -->

### buckets

| Key      | Type                  | Default | Description            | Example |
| -------- | --------------------- | ------- | ---------------------- | ------- |
| managed  | [managed](#managed)   |         | Managed Bucket Object  |         |
| existing | [existing](#existing) |         | Existing Bucket object |         |

### managed

| Key                        | Type                                    | Default | Description                                                      | Example     |
| -------------------------- | --------------------------------------- | ------- | ---------------------------------------------------------------- | ----------- |
| prefix                     | string                                  |         | Creates a unique bucket name beginning with the specified prefix | hello-world |
| reference                  | string                                  |         | Reference to Bucket                                              | hw          |
| lifecycle_rule             | list([lifecycle_rule](#lifecycle_rule)) | []      | A configuration of lifecycle management                          |             |
| bucket_policy              | list([bucket_policy](#bucket_policy))   | []      | A valid bucket policy JSON document                              |             |
| enable_bucket_notification | bool                                    | false   | Enabling Bucket Notification                                     | false       |
| force_destroy              | bool                                    | false   | Enabling Force Destroy                                           | false       |

#### lifecycle_rule

| Key                                    | Type                                                                                  | Default | Description                                                                                                  | Example                                                                                                                     |
| -------------------------------------- | ------------------------------------------------------------------------------------- | ------- | ------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| prefix                                 | string                                                                                |         | Bucket Prefix                                                                                                | staged/                                                                                                                     |
| enabled                                | bool                                                                                  |         | Reference to Bucket                                                                                          | true                                                                                                                        |
| abort_incomplete_multipart_upload_days | int                                                                                   |         | Specifies the number of days after initiating a multipart upload when the multipart upload must be completed | 1                                                                                                                           |
| expiration                             | [expiration](#expiration)                                                             | []      | Specifies a period in the object's expire                                                                    | [Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#expiration)                    |
| transition_storage_class               | [transition_storage_class](#transition_storage_class)                                 | false   | Specifies a period in the object's transitions                                                               | [Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#transition)                    |
| noncurrent_version_transition          | [noncurrent_version_transition](#noncurrent_version_transition)                       | false   | Specifies when noncurrent object versions transition                                                         | [Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#noncurrent-version-expiration) |
| noncurrent_version_expiration_days     | [noncurrent_version_expiration_transition](#noncurrent_version_expiration_transition) |         | Specifies when noncurrent object versions transition                                                         | [Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#noncurrent-version-transition) |

##### expiration

| Key                          | Type | Default | Description                                                                                                                                                                                                                                                               | Example |
| ---------------------------- | ---- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| days                         | int  |         | Specifies the number of days after object creation when the specific rule action takes effect                                                                                                                                                                             | 183     |
| expired_object_delete_marker | bool |         | a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers. This cannot be specified with Days or Date in a Lifecycle Expiration Policy. | true    |

##### transition_storage_class

| Key           | Type | Default | Description                                                                                   | Example             |
| ------------- | ---- | ------- | --------------------------------------------------------------------------------------------- | ------------------- |
| days          | int  |         | Specifies the number of days after object creation when the specific rule action takes effect | 7                   |
| storage_class | int  |         | Specifies the Amazon S3 storage class to which you want the object to transition.             | INTELLIGENT_TIERING |

##### noncurrent_version_transition

| Key           | Type | Default | Description                                                                                   | Example             |
| ------------- | ---- | ------- | --------------------------------------------------------------------------------------------- | ------------------- |
| days          | int  |         | Specifies the number of days after object creation when the specific rule action takes effect | 7                   |
| storage_class | int  |         | Specifies the Amazon S3 storage class to which you want the object to transition.             | INTELLIGENT_TIERING |

##### noncurrent_version_expiration_transition

| Key  | Type | Default | Description                                                                                   | Example |
| ---- | ---- | ------- | --------------------------------------------------------------------------------------------- | ------- |
| days | int  |         | Specifies the number of days after object creation when the specific rule action takes effect | 92      |

#### bucket_policy

Additional bucket policy statements. Default policy allows only SSL requests

### existing

| Key           | Type   | Default | Description                       | Example     |
| ------------- | ------ | ------- | --------------------------------- | ----------- |
| project_name  | string |         | Bucket Prefix                     | hello-world |
| project_group | string |         | Project Group for Existing Bucket | demo        |
| bucket_prefix | string |         | Bucket Prefix for Existing Bucket | jupiter     |
| reference     | string |         | Reference to Bucket               | hw          |

OR

| Key       | Type   | Default | Description         | Example                               |
| --------- | ------ | ------- | ------------------- | ------------------------------------- |
| full_name | string |         | Bucket Full Name    | hello-world20220112134106599600000001 |
| reference | string |         | Reference to Bucket | hw                                    |

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
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [kubernetes_config_map.existing](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/config_map) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of the app | `string` | n/a | yes |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | Team prefix to prepend to managed buckets | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of cluster to deploy app into. | `string` | n/a | yes |
| <a name="input_existing"></a> [existing](#input\_existing) | Existing buckets needing reference by the app | <pre>list(object(<br>    {<br>      full_name     = optional(string)<br>      reference     = optional(string)<br>      read_only     = optional(bool)<br>      project_group = optional(string)<br>      project_name  = optional(string)<br>      bucket_prefix = optional(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Map of Labels to be applied to config maps | `map(string)` | n/a | yes |
| <a name="input_managed"></a> [managed](#input\_managed) | Buckets to be created and managed by terragrunt | `any` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name of the app | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | Config Maps of Buckets |
| <a name="output_policies"></a> [policies](#output\_policies) | Bucket Managed and Existing Policies |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
