# m-portal-aws-sqs
This Terraform module facilitates the creation of Amazon Simple Queue Service (SQS) queues in AWS. It supports the creation of both main queues and Dead Letter Queue (DLQ), allowing for detailed configurations and access policies. **For additional resources, examples, and community engagement**, check out the portal [Cloud Collab Hub](https://cloudcollab.com) :cloud:.

## Usage
**Loading...** ⌛

For more detailed examples and use cases, check out the files in the how-to-usage directory. They provide additional scenarios and explanations for leveraging the features of the aws_sqs module.

## Module Inputs

Here is the table of module inputs based on the provided variables:

### Main Variables

| Variable                                | Type    | Description                                                             | Default     | Required |
|-----------------------------------------|---------|-------------------------------------------------------------------------|-------------|----------|
| create_queue                            | bool    | Whether to create the SQS queue.                                       | true        | no       |
| create_queue_policy                     | bool    | Whether to create a policy for the SQS queue.                          | true        | no       |
| name                                    | string  | The name of the SQS queue.                                             | "" | yes       |
| name_prefix                             | string  | Creates a unique name beginning with the specified prefix.             | null        | no       |
| visibility_timeout_seconds              | number  | The duration (in seconds) that the received messages are hidden from the queue. | 30          | no       |
| message_retention_seconds               | number  | The number of seconds that Amazon SQS retains a message.               | 345600      | no       |
| max_message_size                        | number  | The limit of how many bytes a message can contain before Amazon SQS rejects it. | 262144      | no       |
| delay_seconds                           | number  | The time in seconds that the delivery of all messages in the queue is delayed. | 0           | no       |
| receive_wait_time_seconds               | number  | The maximum wait time for receiving a message from the queue.           | 0           | no       |
| policy                                  | string  | The JSON policy for the SQS queue.                                     | null        | no       |
| fifo_queue                              | bool    | Boolean designating a FIFO queue.                                      | false       | no       |
| content_based_deduplication             | bool    | Boolean designating content-based deduplication.                       | false       | no       |
| sqs_managed_sse_enabled                 | bool    | Boolean designating whether to enable SQS managed server-side encryption. | false    | no       |
| kms_master_key_id                       | string  | The ID of an AWS managed customer master key (CMK) for Amazon SQS or a custom CMK. | null | no       |
| kms_data_key_reuse_period_seconds       | number  | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. | null | no       |
| source_queue_policy_documents           | list(string) | List of IAM policy documents for the source queue.                    | []          | no       |
| queue_policy_statements                 | list(object) | List of policy statements for the SQS queue policy.                    | []          | no       |
| custom_iam_policy_statement             | list(map(string)) | List of custom policy statements for the SQS queue.                | []          | no       |
| producer_principals                     | list(string) | List of AWS principals (users or roles) allowed to send messages to the SQS queue. | [] | no       |
| consumer_principals                     | list(string) | List of AWS principals (users or roles) allowed to receive and delete messages from the SQS queue. | [] | no       |
| admin_principals                        | list(string) | List of AWS principals (users or roles) with full access to the SQS queue. | [] | no       |

### Redrive Policy Variables

| Variable                                | Type    | Description                                                             | Default     | Required |
|-----------------------------------------|---------|-------------------------------------------------------------------------|-------------|----------|
| enable_redrive_policy                   | bool    | Whether to enable the redrive policy.                                   | false       | no       |
| redrive_max_receive_count               | number  | The number of times a message can be received from the source queue before being moved to the dead-letter queue. | 5 | no       |

### Redrive Allow Policy Variables

| Variable                                | Type    | Description                                                             | Default     | Required |
|-----------------------------------------|---------|-------------------------------------------------------------------------|-------------|----------|
| enable_redrive_allow_policy             | bool    | Whether to enable the redrive allow policy.                             | false       | no       |
| allow_all_source_queues                 | bool    | Whether to allow all source queues to access the dead-letter queue.     | true        | no       |
| source_queue_arns                       | list(string) | List of source queue ARNs to allow access to the dead-letter queue. | []          | no       |

### Tags

| Variable                                | Type    | Description                                                             | Default     | Required |
|-----------------------------------------|---------|-------------------------------------------------------------------------|-------------|----------|
| tags                                    | map(string) | A mapping of tags to assign to the resource.                         | {}          | no       |

### Dead Letter Queue (DLQ) Variables

| Variable                                | Type    | Description                                                             | Default     | Required |
|-----------------------------------------|---------|-------------------------------------------------------------------------|-------------|----------|
| create_dlq_queue                        | bool    | Whether to create the Dead Letter Queue (DLQ).                         | false       | no       |
| create_dlq_queue_policy                 | bool    | Whether to create a policy for the SQS DLQ queue.                      | true        | no       |
| dlq_name_prefix                         | string  | Creates a unique name beginning with the specified prefix for the Dead Letter Queue (DLQ). | null | no       |
| dlq_visibility_timeout_seconds          | number  | The duration (in seconds) that the received messages are hidden from the Dead Letter Queue (DLQ). | 30 | no       |
| dlq_message_retention_seconds           | number  | The number of seconds that Amazon SQS retains a message in the Dead Letter Queue (DLQ). | 345600 | no       |
| dlq_max_message_size                    | number  | The limit of how many bytes a message can contain before Amazon SQS rejects it in the Dead Letter Queue (DLQ). | 262144 | no       |
| dlq_delay_seconds                       | number  | The time in seconds that the delivery of all messages in the Dead Letter Queue (DLQ) is delayed. | 0 | no       |
| dlq_receive_wait_time_seconds           | number  | The maximum wait time for receiving a message from the Dead Letter Queue (DLQ). | 0 | no       |
| dlq_policy                              | string  | The JSON policy for the Dead Letter Queue (DLQ).                      | null        | no       |
| dlq_fifo_queue                          | bool    | Boolean designating a FIFO queue for the Dead Letter Queue (DLQ).      | false       | no       |
| dlq_content_based_deduplication         | bool    | Boolean designating content-based deduplication for the Dead Letter Queue (DLQ). | false | no       |
| dlq_sqs_managed_sse_enabled             | bool    | Boolean designating whether to enable SQS managed server-side encryption for the Dead Letter Queue (DLQ). | false | no       |
| dlq_kms_master_key_id                   | string  | The ID of an AWS managed customer master key (CMK) for Amazon SQS or a custom CMK for the Dead Letter

 Queue (DLQ). | null | no       |
| dlq_kms_data_key_reuse_period_seconds   | number  | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages in the Dead Letter Queue (DLQ) before calling AWS KMS again. | null | no       |
| dlq_enable_redrive_allow_policy         | bool    | Whether to enable the redrive allow policy for the Dead Letter Queue (DLQ). | false | no       |
| dlq_allow_all_source_queues             | bool    | Whether to allow all source queues to access the Dead Letter Queue (DLQ). | true | no       |
| dlq_source_queue_arns                   | list(string) | List of source queue ARNs to allow access to the Dead Letter Queue (DLQ). | [] | no       |
| dlq_custom_iam_policy_statement         | list(map(string)) | List of custom policy statements for the Dead Letter Queue (DLQ).      | [] | no       |
| dlq_producer_principals                 | list(string) | List of AWS principals (users or roles) allowed to send messages to the DLQ. | [] | no       |
| dlq_consumer_principals                 | list(string) | List of AWS principals (users or roles) allowed to receive and delete messages from the DLQ. | [] | no       |
| dlq_admin_principals                    | list(string) | List of AWS principals (users or roles) with full access to the DLQ.    | [] | no       |
| dlq_source_queue_policy_documents       | list(string) | List of IAM policy documents for source queue for the Dead Letter Queue (DLQ). | [] | no       |
| dlq_queue_policy_statements             | list(object) | List of policy statements for the Dead Letter Queue (DLQ) policy.       | [] | no       |

## Module outputs

| Output Name            | Description                                      |
|------------------------|--------------------------------------------------|
| sqs_attributes              | All attributes from the SQS queue.              |
| sqs_dlq_attributes          | All attributes from the SQS DLQ queue.          |

## How to Use Output Attributes

arn = module.example_sqs.sqs_attributes.arn
**OR**
arn = module.example_sqs.sqs_dlq_attributes["arn"]

## License

This project is licensed under the MIT License - see the [MIT License](https://opensource.org/licenses/MIT) file for details.

## Contributing

Contributions are welcome! Please follow the guidance below for details on how to contribute to this project:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a pull request
