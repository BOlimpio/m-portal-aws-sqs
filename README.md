## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.6 |
| aws | ~> 2.36 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.36 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| content\_based\_deduplication | Enables content-based deduplication for FIFO queues | `bool` | `false` | no |
| create | Whether to create SQS queue | `bool` | `true` | no |
| delay\_seconds | The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes) | `number` | `0` | no |
| fifo\_queue | Boolean designating a FIFO queue | `bool` | `false` | no |
| kms\_data\_key\_reuse\_period\_seconds | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours) | `number` | `300` | no |
| kms\_master\_key\_id | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | `string` | `null` | no |
| max\_message\_size | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB) | `number` | `262144` | no |
| message\_retention\_seconds | The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days) | `number` | `345600` | no |
| name | This is the human-readable name of the queue. If omitted, Terraform will assign a random name. | `string` | `null` | no |
| name\_prefix | A unique name beginning with the specified prefix. | `string` | `null` | no |
| policy | The JSON policy for the SQS queue | `string` | `""` | no |
| receive\_wait\_time\_seconds | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds) | `number` | `0` | no |
| redrive\_policy | The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ("5") | `string` | `""` | no |
| tag\_app\_group\_email | The email address for the operations team responsible for the deployed asset. | `string` | `null` | no |
| tag\_buc | The Business Unit Code associated with the group responsible for the deployed asset. | `string` | `null` | no |
| tag\_customer\_crmid | The end customer of the system and the CRM ID of the end customer of the system. | `string` | `null` | no |
| tag\_description | A user defined description of the service purpose | `string` | `null` | no |
| tag\_environment\_type | The tier of environment for the application - this is separate from the service level defined at the subscription level. | `string` | `null` | no |
| tag\_name | Common tag name for the resource | `string` | `null` | no |
| tag\_solution\_central\_id | The Asset ID related to the entry in Solution Central for the product to be deployed on the given asset. | `string` | `null` | no |
| tag\_support\_group | The name of the group responsible for the deployed asset. | `string` | `null` | no |
| tag\_tier | The tier of system in the application deployment model. | `string` | `null` | no |
| tags | A mapping of tags to assign to security group | `map(string)` | `{}` | no |
| visibility\_timeout\_seconds | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours) | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_sqs\_queue\_arn | The ARN of the SQS queue |
| this\_sqs\_queue\_id | The URL for the created Amazon SQS queue |
| this\_sqs\_queue\_name | The name of the SQS queue |

