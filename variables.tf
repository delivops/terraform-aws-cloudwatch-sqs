variable "all_alarms_sns_arns" {
  type    = list(string)
  default = []
}
variable "queue_name" {
  type    = string
  default = "my-queue"

}
variable "oldest_message_enabled" {
  type    = bool
  default = true

}
variable "oldest_message_seconds" {
  type    = number
  default = 60

}

variable "oldest_message_sns_arns" {
  type    = list(string)
  default = []

}
variable "in-flight-messages_enabled" {
  type    = bool
  default = true

}
variable "in-flight-messages_counts" {
  type    = number
  default = 100

}
variable "in-flight-messages_sns_arns" {
  type    = list(string)
  default = []

}
variable "high-backlog-messages_enabled" {
  type    = bool
  default = true

}
variable "high-backlog-messages_counts" {
  type    = number
  default = 200

}
variable "high-backlog-messages_sns_arns" {
  type    = list(string)
  default = []

}
variable "minimum-queue-size-enabled" {
  type    = bool
  default = true

}
variable "minimum-queue-size" {
  type    = number
  default = 0

}
variable "minimum-queue-size_sns_arns" {
  type    = list(string)
  default = []

}
variable "tags" {
  type    = map(string)
  default = {}
}

