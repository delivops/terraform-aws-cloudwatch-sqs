[![DelivOps banner](https://raw.githubusercontent.com/delivops/.github/main/images/banner.png?raw=true)](https://delivops.com)

# terraform-aws-cloudwatch-sqs

Terraform module for setting up CloudWatch alarms on AWS SQS queues.

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
  source  = "delivops/cloudwatch-sqs/aws"
  version = "x.x.x"

  queue_name          = "my-app-queue"
  all_alarms_sns_arns = [var.aws_sns_topic_arn]

  # DLQ alarm — fires the moment any message lands in the dead-letter queue
  dlq_alarm_enabled = true
  dlq_name          = "my-app-queue-dlq"
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.consumer_silence](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.dlq_depth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_backlog_messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.in_flight_messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.oldest_message](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.producer_silence](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_alarms_sns_arns"></a> [all\_alarms\_sns\_arns](#input\_all\_alarms\_sns\_arns) | A list of SNS topic ARNs to receive all alarm notifications. | `list(string)` | `[]` | no |
| <a name="input_consumer_silence_enabled"></a> [consumer\_silence\_enabled](#input\_consumer\_silence\_enabled) | Enable alarm when no messages have been deleted from the queue (consumer stopped). | `bool` | `false` | no |
| <a name="input_consumer_silence_sns_arns"></a> [consumer\_silence\_sns\_arns](#input\_consumer\_silence\_sns\_arns) | Additional SNS topic ARNs for the consumer-silence alarm. | `list(string)` | `[]` | no |
| <a name="input_dlq_alarm_enabled"></a> [dlq\_alarm\_enabled](#input\_dlq\_alarm\_enabled) | Enable alarm when messages appear in the dead-letter queue. | `bool` | `false` | no |
| <a name="input_dlq_name"></a> [dlq\_name](#input\_dlq\_name) | The name of the dead-letter queue to monitor. Required when dlq\_alarm\_enabled = true. | `string` | `""` | no |
| <a name="input_dlq_sns_arns"></a> [dlq\_sns\_arns](#input\_dlq\_sns\_arns) | Additional SNS topic ARNs for the DLQ alarm. | `list(string)` | `[]` | no |
| <a name="input_dlq_threshold"></a> [dlq\_threshold](#input\_dlq\_threshold) | Number of DLQ messages that triggers the alarm. | `number` | `1` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | Number of consecutive breaching periods before an alarm fires. Effective window = period × evaluation\_periods. Applies to all alarms except the DLQ alarm. | `number` | `5` | no |
| <a name="input_high_backlog_messages_enabled"></a> [high\_backlog\_messages\_enabled](#input\_high\_backlog\_messages\_enabled) | Enable alarm when the number of visible (backlog) messages exceeds the threshold. | `bool` | `true` | no |
| <a name="input_high_backlog_messages_sns_arns"></a> [high\_backlog\_messages\_sns\_arns](#input\_high\_backlog\_messages\_sns\_arns) | Additional SNS topic ARNs for the backlog-messages alarm. | `list(string)` | `[]` | no |
| <a name="input_high_backlog_messages_threshold"></a> [high\_backlog\_messages\_threshold](#input\_high\_backlog\_messages\_threshold) | Maximum number of visible messages before the backlog alarm triggers. | `number` | `200` | no |
| <a name="input_in_flight_messages_enabled"></a> [in\_flight\_messages\_enabled](#input\_in\_flight\_messages\_enabled) | Enable alarm when in-flight (not-visible) message count exceeds the threshold. | `bool` | `true` | no |
| <a name="input_in_flight_messages_sns_arns"></a> [in\_flight\_messages\_sns\_arns](#input\_in\_flight\_messages\_sns\_arns) | Additional SNS topic ARNs for the in-flight-messages alarm. | `list(string)` | `[]` | no |
| <a name="input_in_flight_messages_threshold"></a> [in\_flight\_messages\_threshold](#input\_in\_flight\_messages\_threshold) | Maximum number of in-flight messages before the alarm triggers. | `number` | `100` | no |
| <a name="input_oldest_message_enabled"></a> [oldest\_message\_enabled](#input\_oldest\_message\_enabled) | Enable alarm when the oldest message in the queue exceeds the age threshold. | `bool` | `true` | no |
| <a name="input_oldest_message_seconds"></a> [oldest\_message\_seconds](#input\_oldest\_message\_seconds) | Age threshold (seconds) for the oldest-message alarm. | `number` | `60` | no |
| <a name="input_oldest_message_sns_arns"></a> [oldest\_message\_sns\_arns](#input\_oldest\_message\_sns\_arns) | Additional SNS topic ARNs for the oldest-message alarm. | `list(string)` | `[]` | no |
| <a name="input_period"></a> [period](#input\_period) | Granularity of each evaluation period in seconds (e.g. 60, 300). Applies to all alarms except the DLQ alarm, which is hardcoded to 60 s for immediate detection. | `number` | `300` | no |
| <a name="input_producer_silence_enabled"></a> [producer\_silence\_enabled](#input\_producer\_silence\_enabled) | Enable alarm when no messages have been sent to the queue (producer stopped). | `bool` | `false` | no |
| <a name="input_producer_silence_sns_arns"></a> [producer\_silence\_sns\_arns](#input\_producer\_silence\_sns\_arns) | Additional SNS topic ARNs for the producer-silence alarm. | `list(string)` | `[]` | no |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | The name of the SQS queue to monitor. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_consumer_silence_alarm_arn"></a> [consumer\_silence\_alarm\_arn](#output\_consumer\_silence\_alarm\_arn) | ARN of the consumer-silence alarm (empty string when disabled). |
| <a name="output_dlq_depth_alarm_arn"></a> [dlq\_depth\_alarm\_arn](#output\_dlq\_depth\_alarm\_arn) | ARN of the DLQ-depth alarm (empty string when disabled). |
| <a name="output_high_backlog_messages_alarm_arn"></a> [high\_backlog\_messages\_alarm\_arn](#output\_high\_backlog\_messages\_alarm\_arn) | ARN of the backlog-messages alarm (empty string when disabled). |
| <a name="output_in_flight_messages_alarm_arn"></a> [in\_flight\_messages\_alarm\_arn](#output\_in\_flight\_messages\_alarm\_arn) | ARN of the in-flight-messages alarm (empty string when disabled). |
| <a name="output_oldest_message_alarm_arn"></a> [oldest\_message\_alarm\_arn](#output\_oldest\_message\_alarm\_arn) | ARN of the oldest-message alarm (empty string when disabled). |
| <a name="output_producer_silence_alarm_arn"></a> [producer\_silence\_alarm\_arn](#output\_producer\_silence\_alarm\_arn) | ARN of the producer-silence alarm (empty string when disabled). |
<!-- END_TF_DOCS -->
