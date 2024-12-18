provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}

module "sqs_alerts" {
  source = "../"




  all_alarms_sns_arns = ["arn:aws:sns:eu-west-1:123456789012:sns"]
  queue_name          = "sqs-1213"
}
