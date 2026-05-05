# ── Oldest message ────────────────────────────────────────────────────────────

resource "aws_cloudwatch_metric_alarm" "oldest_message" {
  count                     = var.oldest_message_enabled ? 1 : 0
  alarm_name                = "SQS | Oldest Message (>${var.oldest_message_seconds}s) | ${var.queue_name}"
  alarm_description         = "The oldest message in ${var.queue_name} is older than ${var.oldest_message_seconds} seconds."
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Maximum"
  threshold                 = var.oldest_message_seconds
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.oldest_message_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.oldest_message_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.oldest_message_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }

  tags = merge(var.tags, {
    Terraform = "true"
  })
}

# ── In-flight messages ────────────────────────────────────────────────────────

resource "aws_cloudwatch_metric_alarm" "in_flight_messages" {
  count                     = var.in_flight_messages_enabled ? 1 : 0
  alarm_name                = "SQS | In-Flight Messages (>${var.in_flight_messages_threshold}) | ${var.queue_name}"
  alarm_description         = "There are too many in-flight (not-visible) messages in ${var.queue_name}."
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "ApproximateNumberOfMessagesNotVisible"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = var.in_flight_messages_threshold
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.in_flight_messages_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.in_flight_messages_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.in_flight_messages_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }

  tags = merge(var.tags, {
    Terraform = "true"
  })
}

# ── Backlog (visible messages) ────────────────────────────────────────────────

resource "aws_cloudwatch_metric_alarm" "high_backlog_messages" {
  count                     = var.high_backlog_messages_enabled ? 1 : 0
  alarm_name                = "SQS | Backlog Messages (>${var.high_backlog_messages_threshold}) | ${var.queue_name}"
  alarm_description         = "Consumers are too slow — visible backlog in ${var.queue_name} exceeds ${var.high_backlog_messages_threshold}."
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = var.high_backlog_messages_threshold
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_backlog_messages_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_backlog_messages_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_backlog_messages_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }

  tags = merge(var.tags, {
    Terraform = "true"
  })
}

# ── DLQ depth ─────────────────────────────────────────────────────────────────

resource "aws_cloudwatch_metric_alarm" "dlq_depth" {
  count                     = var.dlq_alarm_enabled ? 1 : 0
  alarm_name                = "SQS | DLQ Has Messages (>=${var.dlq_threshold}) | ${var.dlq_name}"
  alarm_description         = "Messages have arrived in the dead-letter queue ${var.dlq_name} — consumer failures detected."
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = 60
  statistic                 = "Maximum"
  threshold                 = var.dlq_threshold
  treat_missing_data        = "notBreaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.dlq_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.dlq_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.dlq_sns_arns)

  dimensions = {
    QueueName = var.dlq_name
  }

  tags = merge(var.tags, {
    Terraform = "true"
  })
}

# ── Producer silence ──────────────────────────────────────────────────────────

resource "aws_cloudwatch_metric_alarm" "producer_silence" {
  count                     = var.producer_silence_enabled ? 1 : 0
  alarm_name                = "SQS | Producer Silence (0 messages sent) | ${var.queue_name}"
  alarm_description         = "No messages have been sent to ${var.queue_name} — producer may be down."
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 3
  datapoints_to_alarm       = 3
  metric_name               = "NumberOfMessagesSent"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = 0
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.producer_silence_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.producer_silence_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.producer_silence_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }

  tags = merge(var.tags, {
    Terraform = "true"
  })
}

# ── Consumer silence ──────────────────────────────────────────────────────────

resource "aws_cloudwatch_metric_alarm" "consumer_silence" {
  count                     = var.consumer_silence_enabled ? 1 : 0
  alarm_name                = "SQS | Consumer Silence (0 messages deleted) | ${var.queue_name}"
  alarm_description         = "No messages have been deleted from ${var.queue_name} — consumer may be hung or stopped."
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 3
  datapoints_to_alarm       = 3
  metric_name               = "NumberOfMessagesDeleted"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Sum"
  threshold                 = 0
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.consumer_silence_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.consumer_silence_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.consumer_silence_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }

  tags = merge(var.tags, {
    Terraform = "true"
  })
}