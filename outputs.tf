output "oldest_message_alarm_arn" {
  description = "ARN of the oldest-message alarm (empty string when disabled)."
  value       = length(aws_cloudwatch_metric_alarm.oldest_message) > 0 ? aws_cloudwatch_metric_alarm.oldest_message[0].arn : ""
}

output "in_flight_messages_alarm_arn" {
  description = "ARN of the in-flight-messages alarm (empty string when disabled)."
  value       = length(aws_cloudwatch_metric_alarm.in_flight_messages) > 0 ? aws_cloudwatch_metric_alarm.in_flight_messages[0].arn : ""
}

output "high_backlog_messages_alarm_arn" {
  description = "ARN of the backlog-messages alarm (empty string when disabled)."
  value       = length(aws_cloudwatch_metric_alarm.high_backlog_messages) > 0 ? aws_cloudwatch_metric_alarm.high_backlog_messages[0].arn : ""
}

output "dlq_depth_alarm_arn" {
  description = "ARN of the DLQ-depth alarm (empty string when disabled)."
  value       = length(aws_cloudwatch_metric_alarm.dlq_depth) > 0 ? aws_cloudwatch_metric_alarm.dlq_depth[0].arn : ""
}

output "producer_silence_alarm_arn" {
  description = "ARN of the producer-silence alarm (empty string when disabled)."
  value       = length(aws_cloudwatch_metric_alarm.producer_silence) > 0 ? aws_cloudwatch_metric_alarm.producer_silence[0].arn : ""
}

output "consumer_silence_alarm_arn" {
  description = "ARN of the consumer-silence alarm (empty string when disabled)."
  value       = length(aws_cloudwatch_metric_alarm.consumer_silence) > 0 ? aws_cloudwatch_metric_alarm.consumer_silence[0].arn : ""
}