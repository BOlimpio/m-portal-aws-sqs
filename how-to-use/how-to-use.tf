data "aws_iam_policy_document" "sqs_queue_iam_policy" {
  statement {
    actions = [
      "SQS:*"
    ]
    resources = [
      "*"
    ]
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com", "sqs.amazonaws.com"]
    }
  }

  statement {
    actions = [
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:ReceiveMessage"
    ]
    resources = [
      "arn:aws:sqs:*:*:${var.tier}-${var.product}-trp-omni-parser-queue",
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

  statement {
    actions = [
      "SQS:*"
    ]
    resources = [
      "arn:aws:sqs:*:*:${var.tier}-${var.product}-trp-omni-parser-queue",
    ]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }

}

data "aws_iam_policy_document" "trp-omni-parser-queue-dead-letter-policy" {
  statement {
    actions = [
      "SQS:*"
    ]
    resources = [
      "arn:aws:sqs:*:*:${var.tier}-${var.product}-trp-omni-parser-dead-letter"
    ]
    principals {
      type        = "Service"
      identifiers = ["sqs.amazonaws.com"]
    }
  }
}