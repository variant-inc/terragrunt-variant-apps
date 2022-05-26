# SNS SQS Subscription

## DX Inputs
<!-- markdownlint-disable MD033 MD013 MD041 -->
### SNS Topics

| Key                              | Type   | Default | Description                                                                             | Example                                                                                     | Required |
| -------------------------------- | ------ | ------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | -------- |
| name                             | String |         | The name of the SNS topic to create                                                     | datascience-test-topic                                                                      | yes      |
| display_name                     | String |         | The display name for the SNS topic                                                      | this-is-test                                                                                | optional |
| reference                        | String |         | Short name to refer the SNS topic                                                       | hw                                                                                          | yes      |
| fifo_topic                       | bool   | false   | Boolean indicating whether or not to create a FIFO topic                                | false                                                                                       | optional |
| content_based_deduplication      | bool   | false   | Boolean indicating whether or not to enable content-based deduplication for FIFO topics | false                                                                                       | optional |
| delivery_policy                  | string | null    | The SNS delivery policy                                                                 | [AWS SNS Docs](https://docs.aws.amazon.com/sns/latest/dg/sns-message-delivery-retries.html) | optional |
| sqs_success_feedback_role_arn    | string | null    | The IAM role permitted to receive success feedback for this topic                       | [AWS SNS Docs](https://docs.aws.amazon.com/sns/latest/dg/sns-topic-attributes.html)         | optional |
| sqs_success_feedback_sample_rate | string | null    | Percentage of success to sample                                                         | [AWS SNS Docs](https://docs.aws.amazon.com/sns/latest/dg/sns-topic-attributes.html)         | optional |
| sqs_failure_feedback_role_arn    | string | null    | IAM role for failure feedback                                                           | [AWS SNS Docs](https://docs.aws.amazon.com/sns/latest/dg/sns-topic-attributes.html)         | optional |

### SNS SQS Subscriptions

| Key                               | Type   | Default | Description                                                                                                                           | Example                                                                                                                | Required |
| --------------------------------- | ------ | ------- | ------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | -------- |
| name                              | String |         | This is the human-readable name of the queue                                                                                          | devops-<TOPIC_NAME> # As exists in AWS (including team prefix)                                                         | yes      |
| reference                         | String |         | Short name for referencing the SQS queue                                                                                              | hw                                                                                                                     | yes      |
| topic_name                        | String |         | Topic name to subscribe                                                                                                               | test-topic                                                                                                             | optional |
| fifo_queue                        | bool   | false   | Boolean designating a FIFO queue                                                                                                      | false                                                                                                                  | optional |
| visibility_timeout_seconds        | number | 30      | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)                                                           | [AWS SQS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html) | optional |
| message_retention_seconds         | number | 1209600 | The number of seconds Amazon SQS retains a message                                                                                    | [AWS SQS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)      | optional |
| max_message_size                  | number | 262144  | The limit of how many bytes a message can contain before Amazon SQS rejects it                                                        | [AWS SQS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)      | optional |
| delay_seconds                     | number | 0       | The time in seconds that the delivery of all messages in the queue will be delayed                                                    | [AWS SQS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)      | optional |
| receive_wait_time_seconds         | number | 0       | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning.                           | [AWS SQS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)      | optional |
| policy                            | string | ""      | The JSON policy for the SQS queue                                                                                                     | [AWS SQS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)      | optional |
| content_based_deduplication       | bool   | ""      | Enables content-based deduplication for FIFO queues                                                                                   | false                                                                                                                  | optional |
| kms_data_key_reuse_period_seconds | number | 300     | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again | [AWS SQS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)      | optional |
| dlq                               |        | {}      | Dead letter queue attributes                                                                                                          | [DLQ](#dlq)                                                                                                            | optional |

#### DLQ

| Key                               | Type   | Default | Description                                                                                                                           | Example                 | Required |
| --------------------------------- | ------ | ------- | ------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | -------- |
| name                              | String |         | This is the human-readable name of the dlq queue                                                                                      | devops-<TOPIC_NAME>_dlq | yes      |
| reference                         | String |         | Short name for referencing the SQS DLQ                                                                                                | hw                      | yes      |
| fifo_queue                        | bool   | false   | Boolean designating a FIFO queue                                                                                                      | false   | optional |
| visibility_timeout_seconds        | number | 30      | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)                                                           | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html)    | optional |
| message_retention_seconds         | number | 1209600 | The number of seconds Amazon SQS retains a message                                                                                    | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)    | optional |
| max_message_size                  | number | 262144  | The limit of how many bytes a message can contain before Amazon SQS rejects it                                                        | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)    | optional |
| delay_seconds                     | number | 0       | The time in seconds that the delivery of all messages in the queue will be delayed                                                    | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)    | optional |
| receive_wait_time_seconds         | number | 0       | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning.                           | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)    | optional |
| policy                            | string | ""      | The JSON policy for the SQS queue                                                                                                     | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)    | optional |
| content_based_deduplication       | bool   | ""      | Enables content-based deduplication for FIFO queues                                                                                   | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)    | optional |
| kms_data_key_reuse_period_seconds | number | 300     | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again | [AWS Docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SetQueueAttributes.html)    | optional |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.4.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sns_topic"></a> [sns\_topic](#module\_sns\_topic) | github.com/variant-inc/terraform-aws-sns.git | v1.0 |
| <a name="module_sqs_queue"></a> [sqs\_queue](#module\_sqs\_queue) | github.com/variant-inc/terraform-aws-sns-subscription-sqs | v1.2 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.sns_sqs_subscription_dlqs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.sns_sqs_subscriptions](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map.sns_topics](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [aws_kms_key.sns_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_sns_topic.topics_to_subscribe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |
| [aws_sqs_queue.dlq_queue_urls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sqs_queue) | data source |
| [aws_sqs_queue.queue_urls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sqs_queue) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Release name of the app | `string` | n/a | yes |
| <a name="input_aws_resource_name_prefix"></a> [aws\_resource\_name\_prefix](#input\_aws\_resource\_name\_prefix) | Prefix of team name to be applied to created resources. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Map of Labels to be applied to config maps | `map(string)` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name of the app | `string` | n/a | yes |
| <a name="input_sns_sqs_subscriptions"></a> [sns\_sqs\_subscriptions](#input\_sns\_sqs\_subscriptions) | Map of topic subscription objects. Accepts the following values as keys in each object: [fifo\_queue, visibility\_timeout\_seconds, message\_retention\_seconds, max\_message\_size, delay\_seconds, receive\_wait\_time\_seconds, content\_based\_deduplication, kms\_data\_key\_reuse\_period\_seconds, dlq] | `any` | `{}` | no |
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
