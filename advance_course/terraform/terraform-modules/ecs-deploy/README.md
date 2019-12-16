# Create ECS service and ALB target group module

This module will create:
- ECS service
- Target group(s)
- App autoscaling policy
- App autoscaling Cloudwatch alarm

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| service_name | Name of your service | string  |  | yes |
| container_name | Container name. Use service_name for it | string |  | yes |
| app_autoscaling_enabled | Boolean variable for creating ECS scaling | boolean | 1 | no |
| lb_enabled | Boolean variable to for creating target group and listeners | boolean | 1 | no |
| cluster_id | ECS cluster ID | string |  | yes |
| task_definition_arn | Task definition ARN | string |  | yes |
| desire_count | Number of Task in ECS service | int | 2 | no |
| service_iam_role | IAM role with ALB permission for ECS service | string |  | yes |
| deployment_maximum_percent | The maximum number of tasks, specified as a percentage of the Amazon ECS service's DesiredCount value, that can run in a service during a deployment  | int | 200 | no |
| deployment_minimum_healthy_percent | The minimum number of tasks, specified as a percentage of the Amazon ECS service's DesiredCount value, that must continue to run and remain healthy during a deployment | int | 100 | no |
| container_port | Container port | int | 80 | no |
| scale_max_capacity | Maximum tasks in ECS service | int | | yes |
| scale_min_capacity | Minimum tasks in ECS service | int | | yes |
| scale_out_threshold | Metric threshold to scale out | int | 65 | no |
| scale_in_threshold | Metric threshold to scale in | int | 10 | no |
| scale_out_cooldown_period | The amount of time, in seconds, after a scaling activity completes before any further trigger-related scaling activities can start | int | 60 | no |
| scale_in_cooldown_period | The amount of time, in seconds, after a scaling activity completes before any further trigger-related scaling activities can start | int | 60 | no |
| scale_out_adjustment | Number of tasks to scale down | int | -2 | no |
| scale_in_adjustment | Number of tasks to scale up | int | 2 | no |
| autoscaling_iam_role_arn | IAM role with scaling permission | string | | yes |
| task_spread_strategy | The type of placement strategy | string | default | | no |
| scheduling_strategy |  The scheduling strategy to use for the service | string | REPLICA | no |
| tg_port | Target group port | int | 80 | no |
| vpc_id | VPC id | string | | yes |
| health_path | Path for healthcheck | string | /release | no |
| health_check_interval | Interval of healthcheck | integer | 5 | no |
| health_check_timeout | Healthcheck timeout | integer | 5 | no |
| health_check_healthy_threshold | Healthcheck healthy threshold | integer | 3 | no |
| health_check_unhealthy_threshold | Healthcheck unhealthy threshold | integer | 3 | no |
| http_listener_arn | ARN of the ALB http listener | string | | yes |
| https_listener_arn | ARN of the ALB https listener | string | | yes |
| route53_fqdn | Route53 FQDN for Target group binding | string | | yes |

### Outputs

| Name  | Description |
|---|---|
| ECSServiceARN | ECS service ARN |
| TargetGroupARN | Target group ARN |
| TargetGroupName | Target group Name |
