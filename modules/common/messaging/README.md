<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.74 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | terraform-aws-modules/sns/aws | ~> 3.0 |
| <a name="module_sqs_queue"></a> [sqs\_queue](#module\_sqs\_queue) | terraform-aws-modules/sqs/aws | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic_subscription.topic_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue_policy.topic_subscription_policy_binding](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_iam_policy_document.queue_receive_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.topic_subscription_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.sns_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_sns_topic.topics_to_subscribe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |
| [aws_sqs_queue.queue_urls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sqs_queue) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | Prefix of team name to be applied to created resources. | `string` | n/a | yes |
| <a name="input_topic_subscriptions"></a> [topic\_subscriptions](#input\_topic\_subscriptions) | Map of topic subscription objects. Accepts the following values as keys in each object: [fifo\_queue, visibility\_timeout\_seconds, message\_retention\_seconds, max\_message\_size, delay\_seconds, receive\_wait\_time\_seconds, redrive\_policy, content\_based\_deduplication, kms\_data\_key\_reuse\_period\_seconds] | `map(any)` | `{}` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | Map of topic objects. Accepts the following values as keys in each object: [display\_name, fifo\_topic, content\_based\_deduplication, delivery\_policy, sqs\_success\_feedback\_role\_arn, sqs\_success\_feedback\_sample\_rate, sqs\_failure\_feedback\_role\_arn] | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_env_vars"></a> [env\_vars](#output\_env\_vars) | Environment variables for app use. |
| <a name="output_queue_receive_policy"></a> [queue\_receive\_policy](#output\_queue\_receive\_policy) | AWS IAM Policy document to allow message recieve to created queue(s) |
| <a name="output_sns_topic_publish_policy"></a> [sns\_topic\_publish\_policy](#output\_sns\_topic\_publish\_policy) | AWS IAM Policy document to allow publish to created topic(s) |
| <a name="output_sns_topics"></a> [sns\_topics](#output\_sns\_topics) | SNS Topics Output |
| <a name="output_sqs_queues"></a> [sqs\_queues](#output\_sqs\_queues) | SQS Queues Output |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->