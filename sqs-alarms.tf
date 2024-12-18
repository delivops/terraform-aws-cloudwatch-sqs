resource "aws_cloudwatch_metric_alarm" "sqs-priority-queue-delay-warning" {
  count                     = var.oldest_message_enabled ? 1 : 0
  alarm_name                = "SQS | Priority Queue Delay (>${var.oldest_message_seconds}s) | ${var.queue_name}"
  alarm_description         = "The oldest message in ${var.queue_name} is older than ${var.oldest_message_seconds} seconds"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Average"
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
resource "aws_cloudwatch_metric_alarm" "sqs-in-flight-messages-warning" {
  count                     = var.in-flight-messages_enabled ? 1 : 0
  alarm_name                = "SQS | In-Flight Messages (>${var.in-flight-messages_counts}) | ${var.queue_name}"
  alarm_description         = "There are too much messages in-flight in ${var.queue_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "ApproximateNumberOfMessagesNotVisible"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = var.in-flight-messages_counts
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.in-flight-messages_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.in-flight-messages_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.in-flight-messages_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }
  tags = merge(var.tags, {
    Terraform = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "sqs-backlog-messages-warning" {
  count                     = var.high-backlog-messages_enabled ? 1 : 0
  alarm_name                = "SQS | Backlog Messages (>${var.high-backlog-messages_counts}) | ${var.queue_name}"
  alarm_description         = "Consumer are too slow in ${var.queue_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = var.high-backlog-messages_counts
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high-backlog-messages_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high-backlog-messages_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high-backlog-messages_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }
  tags = merge(var.tags, {
    Terraform = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "sqs-minimum-queue-size-warning" {
  count                     = var.minimum-queue-size-enabled ? 1 : 0
  alarm_name                = "SQS | Minimum Queue Size (<${var.minimum-queue-size}) | ${var.queue_name}"
  alarm_description         = "The queue ${var.queue_name} is too small, can be provider issue"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "NumberOfMessagesSent"
  namespace                 = "AWS/SQS"
  period                    = 300
  statistic                 = "Average"
  threshold                 = var.minimum-queue-size
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.minimum-queue-size_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.minimum-queue-size_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.minimum-queue-size_sns_arns)

  dimensions = {
    QueueName = var.queue_name
  }
  tags = merge(var.tags, {
    Terraform = "true"
  })
}

