<!-- markdownlint-disable MD033 MD013 MD041 -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.iaac_replicator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of cluster to deploy app into. | `string` | n/a | yes |
| <a name="input_actions_octopus_version"></a> [actions\_octopus\_version](#input\_actions\_octopus\_version) | Actions Octopus version | `string` | `"v3"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace of the app | `string` | n/a | yes |
| <a name="input_release_data"></a> [release\_data](#input\_release\_data) | Map of release data | <pre>object({<br>    space             = string<br>    project           = string<br>    repository        = string<br>    user              = string<br>    version           = string<br>    image             = string<br>    is_infrastructure = bool<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources | `map(any)` | n/a | yes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->