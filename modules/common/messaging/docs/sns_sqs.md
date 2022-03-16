## SNS

Create SNS Topics with optional configuration. This need to be added under infrastructure section with attribute topics and support attributes. Skipping this section will not add topics to the application configuration.

Adding topic with below format will create an env variable and can be referenced as TOPIC__<TOPIC_NAME>__arn in the code

### topics

### Supported attributes under topics


## SQS

Create SQS Queues and subscribe to an SNS Topics with options. This need to be added under infrastructure section with attribute topic_subscriptions and support attributes. Skipping this section will not add topic subscription to queues. It is suggested to create only one queue per application.

Adding topic with below format will create an env variable and can be referenced as QUEUE__<QUEUE_NAME>__url in the code.

### topic_subscriptions