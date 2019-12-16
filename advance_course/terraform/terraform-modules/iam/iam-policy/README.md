## Create IAM policy module

This module will create
- IAM policy

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| service_name | Name of your service | string  |  | yes |
| description | Policy description | string |  | yes |
| policy_data | Policy data | json |  | yes |

### Outputs

| Name  | Description |
|---|---|
| PolicyARN | ARN of the created IAM policy |

### Example

```hcl
  data "template_file" "custom_policy" {
    template = "${file("./templates/sqs_policy.json")}"
    vars {
      TestName = "Value"
    }
  }

  module "iam-policy" {
    source = "../terraform-modules//iam/iam-policy"
    service_name = "${var.service_name}"
    description = "Policy for ${var.service_name}"
    policy_data = "${data.template_file.custom_policy.rendered}"
  }
```

This code will render the `sqs_policy.json` with provided `vars` and module
`iam-policy` will create custom policy with given policy data.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": [
            "sqs:DeleteMessage",
            "sqs:DeleteMessageBatch",
            "sqs:GetQueueAttributes",
            "sqs:GetQueueUrl",
            "sqs:ListQueues",
            "sqs:ReceiveMessage",
            "sqs:SendMessage",
            "sqs:SendMessageBatch"
        ],
        "Effect": "Allow",
        "Resource": [
            "${TestName}"
        ]
      }
    ]
}
```
