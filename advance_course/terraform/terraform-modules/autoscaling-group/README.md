## Create ASG module

This module will create:
- Launch configuration
- Autoscaling group
- Scaling policies
- Cloudwatch alarms

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| name | Name of the ASG | string |  | yes |
| aws_ami | AMI id | string | true | yes |
| instance_type | Instance type | string | t2.medium | no |
| iam_instance_profile_arn | ARN of instance profile | string |  | yes |
| environment | Environment | string | | yes |
| subnet_ids | IDs of subnets | list |  | yes |
| security_groups | Security group for instances in ASG | list | | yes |
| enable_monitoring | Enable detailed monitoring on an instance as you launch | boolean | false | no |
| volume_size | Volume size of created instances | string | 50 | no |
| scale_max_capacity | Maximum instances in ASG | string | 4 | no |
| scale_min_capacity | Minimum instances in ASG | string | 2 | no |
| desired_capacity | Number of instances in ASG | string | 2 | no |
| availability_zones | List of availability zones | list | "us-east-1b", "us-east-1c", "us-east-1a" | no |
| lifecycle_hook | Provide true if you want to create lifecycle hook | boolean | false | no |
| notify_target | SNS or SQS ARN | string | | yes |
| notify_role_arn | Role ARN with permissions for SNS and SQS | string | no |
| user_data | Rendered user data for launch configuration| rendered_data | | yes |
| down_alarm_threshold | Threshold for Cloudwatch ASG down alarm | string | 10 | no |
| up_alarm_threshold | Threshold for Cloudwatch ASG up alarm | string | 80 | no |

### Outputs

| Name  | Description |
|---|---|
| LaunchConfigurationId | Launch configuration ID |
| LaunchConfigurationName | Launch configuration Name |
| AutoscalingGroupId | Autoscaling group ID |
| AutoscalingGroupARN | Autoscaling group ARN |
| AutoscalingGroupName | Autoscaling group Name |
