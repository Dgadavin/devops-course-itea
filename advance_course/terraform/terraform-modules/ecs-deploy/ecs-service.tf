resource "aws_ecs_service" "ECSService" {
  count = "${var.lb_enabled ? 1 : 0}"
  name            = "${var.service_name}"
  cluster         = "${var.cluster_id}"
  task_definition = "${var.task_definition_arn}"
  desired_count   = "${var.desire_count}"
  iam_role        = "${var.service_iam_role}"
  scheduling_strategy = "${var.scheduling_strategy}"
  deployment_maximum_percent = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  lifecycle {
    ignore_changes = ["desired_count"]
  }
  load_balancer {
    target_group_arn = "${aws_lb_target_group.TargetGroup.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }
  ordered_placement_strategy {
    type = "spread"
    field = "${var.task_spread_strategy == "default" ? "attribute:ecs.availability-zone" : var.task_spread_strategy}"
  }
  ordered_placement_strategy {
    type = "spread"
    field = "instanceId"
  }
  depends_on = ["aws_lb_listener_rule.HTTPListener"]
}

resource "aws_ecs_service" "ECSServiceWithoutLB" {
  count = "${!var.lb_enabled ? 1 : 0}"
  name            = "${var.service_name}"
  cluster         = "${var.cluster_id}"
  task_definition = "${var.task_definition_arn}"
  desired_count   = "${var.desire_count}"
  deployment_maximum_percent = "${var.deployment_maximum_percent}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  lifecycle {
    ignore_changes = ["desired_count"]
  }
  ordered_placement_strategy {
    type = "spread"
    field = "${var.task_spread_strategy == "default" ? "attribute:ecs.availability-zone" : var.task_spread_strategy}"
  }
  ordered_placement_strategy {
    type = "spread"
    field = "instanceId"
  }
}

resource "aws_appautoscaling_target" "AppAsgTarget" {
  count = "${var.app_autoscaling_enabled ? 1 : 0}"
  max_capacity       = "${var.scale_max_capacity}"
  min_capacity       = "${var.scale_min_capacity}"
  resource_id        = "${var.lb_enabled ? format("%s%s%s%s", "service/", "${var.cluster_id}", "/", join(" ", aws_ecs_service.ECSService.*.name)) : format("%s%s%s%s", "service/", "${var.cluster_id}", "/", join(" ", aws_ecs_service.ECSServiceWithoutLB.*.name))}"
  role_arn           = "${var.autoscaling_iam_role_arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale-down" {
  count = "${var.app_autoscaling_enabled ? 1 : 0}"
  name                    = "scale-down-${var.service_name}"
  policy_type             = "StepScaling"
  resource_id             = "${var.lb_enabled ? format("%s%s%s%s", "service/", "${var.cluster_id}", "/", join(" ", aws_ecs_service.ECSService.*.name)) : format("%s%s%s%s", "service/", "${var.cluster_id}", "/", join(" ", aws_ecs_service.ECSServiceWithoutLB.*.name))}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = "${var.scale_in_cooldown_period}"
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = "${var.scale_in_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.AppAsgTarget"]
}

resource "aws_cloudwatch_metric_alarm" "EcsLowAlarm" {
  count = "${var.app_autoscaling_enabled ? 1 : 0}"
  alarm_name          = "${var.service_name}-EcsLowAlarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.scale_in_cooldown_period}"
  statistic           = "Average"
  threshold           = "${var.scale_in_threshold}"

  dimensions {
    ClusterName = "${var.cluster_id}"
    ServiceName = "${var.lb_enabled ? join(" ", aws_ecs_service.ECSService.*.name) : join(" ", aws_ecs_service.ECSServiceWithoutLB.*.name)}"
  }

  alarm_description = "This metric monitors ecs cpu utilization"
  alarm_actions     = ["${aws_appautoscaling_policy.scale-down.arn}"]
}

resource "aws_appautoscaling_policy" "scale-up" {
  count = "${var.app_autoscaling_enabled ? 1 : 0}"
  name                    = "scale-up-${var.service_name}"
  policy_type             = "StepScaling"
  resource_id             = "${var.lb_enabled ? format("%s%s%s%s", "service/", "${var.cluster_id}", "/", join(" ", aws_ecs_service.ECSService.*.name)) : format("%s%s%s%s", "service/", "${var.cluster_id}", "/", join(" ", aws_ecs_service.ECSServiceWithoutLB.*.name))}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = "${var.scale_out_cooldown_period}"
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = "${var.scale_out_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.AppAsgTarget"]
}

resource "aws_cloudwatch_metric_alarm" "EcsHighAlarm" {
  count = "${var.app_autoscaling_enabled ? 1 : 0}"
  alarm_name          = "${var.service_name}-EcsHighAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.scale_out_cooldown_period}"
  statistic           = "Average"
  threshold           = "${var.scale_out_threshold}"

  dimensions {
    ClusterName = "${var.cluster_id}"
    ServiceName = "${var.lb_enabled ? join(" ", aws_ecs_service.ECSService.*.name) : join(" ", aws_ecs_service.ECSServiceWithoutLB.*.name)}"
  }

  alarm_description = "This metric monitors ecs cpu utilization"
  alarm_actions     = ["${aws_appautoscaling_policy.scale-up.arn}"]
}
