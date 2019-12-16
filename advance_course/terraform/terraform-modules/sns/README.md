## Create SNS topic module

This module will create
- SNS topic

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| topic_name | Name of your topic | string  |  | yes |

### Outputs

| Name  | Description |
|---|---|
| SNSTopicARN | ARN of the created SNS topic |

### Example

  module "sns-topic" {
    source = "../terraform-modules//sns"
    topic_name = "${var.topic_name}"
  }
