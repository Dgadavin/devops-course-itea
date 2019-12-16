variable "network_mode" { default = "bridge" }
variable "family" {}
variable "task_template" {}
variable "task_role_arn" {}
variable "isVolume" { default = false }
variable "volume_name" { default = "base_volume" }
variable "volume_path" { default = "/etc" }
variable "execution_role_arn" { default = "" }

resource "aws_ecs_task_definition" "TaskDefinitionWithVol" {
  count = "${var.isVolume}"
  family = "${var.family}"
  container_definitions = "${var.task_template}"
  task_role_arn = "${var.task_role_arn}"
  network_mode = "${var.network_mode}"
  execution_role_arn = "${var.execution_role_arn}"
  volume {
    name      = "${var.volume_name}"
    host_path = "${var.volume_path}"
  }
}

resource "aws_ecs_task_definition" "TaskDefinition" {
  count = "${var.isVolume ? 0 : 1}"
  family = "${var.family}"
  container_definitions = "${var.task_template}"
  task_role_arn = "${var.task_role_arn}"
  network_mode = "${var.network_mode}"
  execution_role_arn = "${var.execution_role_arn}"
}

output "TaskDefinitionARN" {
  value = "${ join(" ", aws_ecs_task_definition.TaskDefinition.*.arn) }"
}

output "TaskDefinitionARNVol" {
  value = "${ join(" ", aws_ecs_task_definition.TaskDefinitionWithVol.*.arn) }"
}
