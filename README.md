![image info](logo.jpeg)

# Terraform-aws-target-group-monitor

Terraform-aws-sqs-monitor is a Terraform module for setting up a notification system about cloudwatch metrics.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Information

The tags that you use for your module should be unique, and fit exactly to one sqs.

## Usage

The module will create a notification system to alert about errors in SQS.
Use this module multiple times to create repositories with different configurations.

Include this repository as a module in your existing terraform code:

```python

################################################################################
# AWS SQS
################################################################################

provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}

module "sqs_alerts" {
  source = "delivops/cloudwatch-sqs/aws"
  #version            = "0.0.2"



  aws_sns_topics_arns        = [var.aws_sns_topic_arn]
  queue_name                 = "sqs-1213"
}

```
