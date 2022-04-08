<!-- markdownlint-disable MD033 MD013 MD041 -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.4.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | github.com/variant-inc/terraform-aws-sns.git | v1 |
| <a name="module_sqs_queue"></a> [sqs\_queue](#module\_sqs\_queue) | github.com/variant-inc/terraform-aws-sns-subscription-sqs | v1 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.sns_sqs_subscriptions](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.sns_topics](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [aws_kms_key.sns_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_sns_topic.topics_to_subscribe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |
| [aws_sqs_queue.queue_urls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sqs_queue) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of the app | `string` | n/a | yes |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | Prefix of team name to be applied to created resources. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name of the app | `string` | n/a | yes |
| <a name="input_sns_sqs_subscriptions"></a> [sns\_sqs\_subscriptions](#input\_sns\_sqs\_subscriptions) | Map of topic subscription objects. Accepts the following values as keys in each object: [fifo\_queue, visibility\_timeout\_seconds, message\_retention\_seconds, max\_message\_size, delay\_seconds, receive\_wait\_time\_seconds, redrive\_policy, content\_based\_deduplication, kms\_data\_key\_reuse\_period\_seconds] | `any` | `{}` | no |
| <a name="input_sns_topics"></a> [sns\_topics](#input\_sns\_topics) | Map of topic objects. Accepts the following values as keys in each object: [display\_name, fifo\_topic, content\_based\_deduplication, delivery\_policy, sqs\_success\_feedback\_role\_arn, sqs\_success\_feedback\_sample\_rate, sqs\_failure\_feedback\_role\_arn] | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_maps"></a> [config\_maps](#output\_config\_maps) | Config Maps of SNS and SQS |
| <a name="output_queue_receive_policy"></a> [queue\_receive\_policy](#output\_queue\_receive\_policy) | AWS IAM Policy document to allow message recieve to created queue(s) |
| <a name="output_sns_topic_publish_policy"></a> [sns\_topic\_publish\_policy](#output\_sns\_topic\_publish\_policy) | AWS IAM Policy document to allow publish to created topic(s) |
| <a name="output_sns_topics"></a> [sns\_topics](#output\_sns\_topics) | SNS Topics Output |
| <a name="output_sqs_queues"></a> [sqs\_queues](#output\_sqs\_queues) | SQS Queues Output |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
