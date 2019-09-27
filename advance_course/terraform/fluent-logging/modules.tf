resource "aws_ecs_task_definition" "TaskDefinition" {
  family = "${var.service_name}"
  container_definitions = "${data.template_file.FluentServiceTemplate.rendered}"
  task_role_arn = "${aws_iam_role.task-role.arn}"
  network_mode = "bridge"
}

resource "aws_ecs_service" "itea-cluster" {
  name            = "${var.service_name}"
  cluster         = "${var.cluster_id}"
  task_definition = "${aws_ecs_task_definition.TaskDefinition.arn}"
  scheduling_strategy = "DAEMON"
}