# Create ECS task definition module

This module will create:
- ECS task definition

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| network_mode | Task definition(docker) network mode | string  | bridge | no |
| family | Name of Task definition | string |  | yes |
| task_template | Task definition template | json | | yes |
| task_role_arn | IAM role ARN for Task definition | string | | yes |
| isVolume | Trigger for creating Task definition with volume | boolean | false | no |
| volume_name | Volume name | string | base_volume | no |
| volume_path | Volume path | string | /etc | no |

### Outputs

| Name  | Description |
|---|---|
| TaskDefinitionARN | Task definition ARN without volume |
| TaskDefinitionARNVol | Task definition ARN with volume |
