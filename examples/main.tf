provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "alerts" {
  name         = "sqs-alerts"
  display_name = "SQS Alerts"
}

module "sqs_alerts" {
  source = "../"

  queue_name          = "my-app-queue"
  all_alarms_sns_arns = [aws_sns_topic.alerts.arn]

  # Oldest message waiting in the queue
  oldest_message_enabled = true
  oldest_message_seconds = 120

  # Too many in-flight messages (consumers slow / hung)
  in_flight_messages_enabled   = true
  in_flight_messages_threshold = 200

  # Queue backlog is growing (consumers not keeping up)
  high_backlog_messages_enabled   = true
  high_backlog_messages_threshold = 500

  # DLQ — fires the moment any message lands in the dead-letter queue
  dlq_alarm_enabled = true
  dlq_name          = "my-app-queue-dlq"

  # Uncomment to detect producer / consumer outages:
  # producer_silence_enabled = true
  # consumer_silence_enabled = true

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}