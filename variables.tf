variable "aws_sns_topics_arns" {
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
variable "in-flight-messages_enabled" {
  type    = bool
  default = true

}
variable "in-flight-messages_counts" {
  type    = number
  default = 100

}
variable "high-backlog-messages_enabled" {
  type    = bool
  default = true
  
}
variable "high-backlog-messages_counts" {
  type    = number
  default = 200
  
}
variable "minimum-queue-size-enabled" {
  type    = bool
  default = true
  
}
variable "minimum-queue-size" {
  type    = number
  default = 0
  
}

