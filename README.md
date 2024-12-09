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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.sqs-backlog-messages-warning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.sqs-in-flight-messages-warning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.sqs-minimum-queue-size-warning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.sqs-priority-queue-delay-warning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_sns_topics_arns"></a> [aws\_sns\_topics\_arns](#input\_aws\_sns\_topics\_arns) | n/a | `list(string)` | `[]` | no |
| <a name="input_high-backlog-messages_counts"></a> [high-backlog-messages\_counts](#input\_high-backlog-messages\_counts) | n/a | `number` | `200` | no |
| <a name="input_high-backlog-messages_enabled"></a> [high-backlog-messages\_enabled](#input\_high-backlog-messages\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_in-flight-messages_counts"></a> [in-flight-messages\_counts](#input\_in-flight-messages\_counts) | n/a | `number` | `100` | no |
| <a name="input_in-flight-messages_enabled"></a> [in-flight-messages\_enabled](#input\_in-flight-messages\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_minimum-queue-size"></a> [minimum-queue-size](#input\_minimum-queue-size) | n/a | `number` | `0` | no |
| <a name="input_minimum-queue-size-enabled"></a> [minimum-queue-size-enabled](#input\_minimum-queue-size-enabled) | n/a | `bool` | `true` | no |
| <a name="input_oldest_message_enabled"></a> [oldest\_message\_enabled](#input\_oldest\_message\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_oldest_message_seconds"></a> [oldest\_message\_seconds](#input\_oldest\_message\_seconds) | n/a | `number` | `60` | no |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | n/a | `string` | `"my-queue"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->