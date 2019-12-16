## IAM policy attach module

This module will create
- attach inline or embedded AWS policy to the given IAM role

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| iam_role_name | IAM role name | string  |  | yes |
| policy_arn | ARN of policy to attach | string |  | yes |

### Example

```hcl
  module "custom-policy-attachment" {
    source = "../terraform-modules//iam/iam-policy-attach"
    iam_role_name = "${module.iam-role.IAMRoleName}"
    policy_arn = "${module.iam-policy.PolicyARN}"
  }

  module "embeded-policy-attachment" {
    source = "../terraform-modules//iam/iam-policy-attach"
    iam_role_name = "${module.iam-role.IAMRoleName}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  }
```
