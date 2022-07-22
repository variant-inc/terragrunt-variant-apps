<!-- markdownlint-disable MD033 MD013 MD041 -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1.1 |

## Resources

| Name | Type |
|------|------|
| [null_resource.create_namespace](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of cluster to deploy app into. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes Namespace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_name"></a> [namespace\_name](#output\_namespace\_name) | Namespace Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->