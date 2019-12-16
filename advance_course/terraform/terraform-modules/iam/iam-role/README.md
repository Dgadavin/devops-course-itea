## Create IAM role module

This module will create
- IAM role
- IAM instance profile

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| service_name | Name of your service | string  |  | yes |
| trusted_name | Value of trusted relationship | string |  | yes |
| instance_profile | Provide with true for crating instance profile | boolean | false | no |

### Outputs

| Name  | Description |
|---|---|
| IAMRoleARN | ARN of the created IAM role |
| IAMRoleName | Name of the created IAM role |
|InstanceProfileARN | ARN of the instance profile |

### Example

```hcl
  module "iam-role" {
    source = "../terraform-modules//iam/iam-role"
    service_name = "${var.service_name}"
    trusted_name = "ecs-tasks"
  }
```

### How to use in your code

```hcl
  task_role_arn = "${module.iam-role.IAMRoleARN}"
```
This will return the IAM role ARN
