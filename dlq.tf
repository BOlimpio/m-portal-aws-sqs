#####################
##### DLQ Queue #####
#####################

resource "aws_sqs_queue" "dlq" {
  count = var.create_dlq_queue ? 1 : 0

  name        = "${var.name}-dlq"
  name_prefix = var.dlq_name_prefix

  visibility_timeout_seconds  = var.dlq_visibility_timeout_seconds
  message_retention_seconds   = var.dlq_message_retention_seconds
  max_message_size            = var.dlq_max_message_size
  delay_seconds               = var.dlq_delay_seconds
  receive_wait_time_seconds   = var.dlq_receive_wait_time_seconds
  policy                      = var.dlq_policy
  fifo_queue                  = var.dlq_fifo_queue
  content_based_deduplication = var.dlq_content_based_deduplication
  sqs_managed_sse_enabled     = var.dlq_sqs_managed_sse_enabled

  kms_master_key_id                 = var.dlq_kms_master_key_id
  kms_data_key_reuse_period_seconds = var.dlq_kms_data_key_reuse_period_seconds

  tags = merge(
    var.tags,
    map("Name", "${var.name}-dlq")
  )
}

resource "aws_sqs_queue_redrive_allow_policy" "dlq_redrive_allow_policy" {
  count = var.enable_redrive_allow_policy && var.create_dlq_queue ? 1 : 0

  queue_url        = aws_sqs_queue.dlq[0].id
  redrive_allow_policy = jsonencode({
    redrivePermission = var.allow_all_source_queues ? "all" : "byQueue"
    sourceQueueArns   = var.source_queue_arns
  })
}

data "aws_iam_policy_document" "dlq" {
  count = var.create_dlq_queue_policy && var.create_dlq_queue ? 1 : 0

  source_policy_documents   = var.dlq_source_queue_policy_documents

  dynamic "statement" {
    for_each = var.dlq_queue_policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = try(statement.value.resources, [aws_sqs_queue.dlq[0].arn])
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_sqs_queue_policy" "dlq" {
  count = var.create_dlq_queue_policy && var.create_dlq_queue ? 1 : 0

  queue_url = aws_sqs_queue.dlq[0].url
  policy    = data.aws_iam_policy_document.dlq[0].json
}
