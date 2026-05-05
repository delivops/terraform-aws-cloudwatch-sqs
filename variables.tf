variable "queue_name" {
  description = "The name of the SQS queue to monitor."
  type        = string
}

variable "all_alarms_sns_arns" {
  description = "A list of SNS topic ARNs to receive all alarm notifications."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

# ── Evaluation window (shared by all alarms except DLQ) ─────────────────────

variable "period" {
  description = "Granularity of each evaluation period in seconds (e.g. 60, 300). Applies to all alarms except the DLQ alarm, which is hardcoded to 60 s for immediate detection."
  type        = number
  default     = 300
}

variable "evaluation_periods" {
  description = "Number of consecutive breaching periods before an alarm fires. Effective window = period × evaluation_periods. Applies to all alarms except the DLQ alarm."
  type        = number
  default     = 5
}

# ── Oldest message (ApproximateAgeOfOldestMessage) ──────────────────────────

variable "oldest_message_enabled" {
  description = "Enable alarm when the oldest message in the queue exceeds the age threshold."
  type        = bool
  default     = true
}

variable "oldest_message_seconds" {
  description = "Age threshold (seconds) for the oldest-message alarm."
  type        = number
  default     = 60
}

variable "oldest_message_sns_arns" {
  description = "Additional SNS topic ARNs for the oldest-message alarm."
  type        = list(string)
  default     = []
}

# ── In-flight messages (ApproximateNumberOfMessagesNotVisible) ───────────────

variable "in_flight_messages_enabled" {
  description = "Enable alarm when in-flight (not-visible) message count exceeds the threshold."
  type        = bool
  default     = true
}

variable "in_flight_messages_threshold" {
  description = "Maximum number of in-flight messages before the alarm triggers."
  type        = number
  default     = 100
}

variable "in_flight_messages_sns_arns" {
  description = "Additional SNS topic ARNs for the in-flight-messages alarm."
  type        = list(string)
  default     = []
}

# ── Backlog / visible messages (ApproximateNumberOfMessagesVisible) ──────────

variable "high_backlog_messages_enabled" {
  description = "Enable alarm when the number of visible (backlog) messages exceeds the threshold."
  type        = bool
  default     = true
}

variable "high_backlog_messages_threshold" {
  description = "Maximum number of visible messages before the backlog alarm triggers."
  type        = number
  default     = 200
}

variable "high_backlog_messages_sns_arns" {
  description = "Additional SNS topic ARNs for the backlog-messages alarm."
  type        = list(string)
  default     = []
}

# ── DLQ depth (ApproximateNumberOfMessagesVisible on the DLQ) ────────────────

variable "dlq_alarm_enabled" {
  description = "Enable alarm when messages appear in the dead-letter queue."
  type        = bool
  default     = false
}

variable "dlq_name" {
  description = "The name of the dead-letter queue to monitor. Required when dlq_alarm_enabled = true."
  type        = string
  default     = ""
}

variable "dlq_threshold" {
  description = "Number of DLQ messages that triggers the alarm."
  type        = number
  default     = 1
}

variable "dlq_sns_arns" {
  description = "Additional SNS topic ARNs for the DLQ alarm."
  type        = list(string)
  default     = []
}

# ── Producer silence (NumberOfMessagesSent = 0) ──────────────────────────────

variable "producer_silence_enabled" {
  description = "Enable alarm when no messages have been sent to the queue (producer stopped)."
  type        = bool
  default     = false
}

variable "producer_silence_sns_arns" {
  description = "Additional SNS topic ARNs for the producer-silence alarm."
  type        = list(string)
  default     = []
}

# ── Consumer silence (NumberOfMessagesDeleted = 0) ───────────────────────────

variable "consumer_silence_enabled" {
  description = "Enable alarm when no messages have been deleted from the queue (consumer stopped)."
  type        = bool
  default     = false
}

variable "consumer_silence_sns_arns" {
  description = "Additional SNS topic ARNs for the consumer-silence alarm."
  type        = list(string)
  default     = []
}