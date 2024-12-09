resource "aws_cloudwatch_metric_alarm" "sqs-priority-queue-delay-warning" {
  count               = var.oldest_message_enabled ? 1 : 0
  alarm_name          = "SQS | ${var.queue_name} | Priority Queue Delay"
  alarm_description   = "The oldest message in ${var.queue_name} is older than ${var.oldest_message_seconds} seconds"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "15" //for in minutes
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Average"
  threshold           = var.oldest_message_seconds
  treat_missing_data  = "missing"
  datapoints_to_alarm = 15
  alarm_actions       = var.aws_sns_topics_arns
  dimensions = {
    QueueName = var.queue_name
  }
  tags = merge(var.tags, {
    Terraform = "true"
  })
}
resource "aws_cloudwatch_metric_alarm" "sqs-in-flight-messages-warning" {
  count               = var.in-flight-messages_enabled ? 1 : 0
  alarm_name          = "SQS | ${var.queue_name} | In-Flight Messages Delay"
  alarm_description   = "There are too much messages in-flight in ${var.queue_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "15" //for in minutes
  metric_name         = "ApproximateNumberOfMessagesNotVisible"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Average"
  threshold           = var.in-flight-messages_counts
  treat_missing_data  = "missing"
  datapoints_to_alarm = 15
  alarm_actions       = var.aws_sns_topics_arns
  dimensions = {
    QueueName = var.queue_name
  }
  tags = merge(var.tags, {
    Terraform = "true"
  })
}
resource "aws_cloudwatch_metric_alarm" "sqs-backlog-messages-warning" {
  count               = var.high-backlog-messages_enabled ? 1 : 0
  alarm_name          = "SQS | ${var.queue_name} | Backlog Messages Delay"
  alarm_description   = "Consumer are too slow in ${var.queue_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "15" //for in minutes
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Average"
  threshold           = var.high-backlog-messages_counts
  treat_missing_data  = "missing"
  datapoints_to_alarm = 15
  alarm_actions       = var.aws_sns_topics_arns
  dimensions = {
    QueueName = var.queue_name
  }
  tags = merge(var.tags, {
    Terraform = "true"
  })
}
resource "aws_cloudwatch_metric_alarm" "sqs-minimum-queue-size-warning" {
  count               = var.minimum-queue-size-enabled ? 1 : 0
  alarm_name          = "SQS | ${var.queue_name} | Minimum Queue Size"
  alarm_description   = "The queue ${var.queue_name} is too small, can be provider issue"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "15" //for in minutes
  metric_name         = "NumberOfMessagesSent"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Average"
  threshold           = var.minimum-queue-size
  treat_missing_data  = "missing"
  datapoints_to_alarm = 15
  alarm_actions       = var.aws_sns_topics_arns
  dimensions = {
    QueueName = var.queue_name
  }
  tags = merge(var.tags, {
    Terraform = "true"
  })
}

