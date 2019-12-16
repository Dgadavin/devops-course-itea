resource "aws_cloudwatch_metric_alarm" "autoscaling_up_alarm" {
  alarm_name = "${var.name}-${var.environment}-autoscale-up"
  alarm_description = "${var.name}-${var.environment} Autoscaling UP Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "${var.up_alarm_threshold}"
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.autoscaling_group.name}"
    }
    actions_enabled = true
    alarm_actions = ["${aws_autoscaling_policy.autoscaling_policy_up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "autoscaling_down_alarm" {
  alarm_name = "${var.name}-${var.environment}-autoscale-down"
  alarm_description = "${var.name}-${var.environment} Autoscaling down Alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "${var.down_alarm_threshold}"
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.autoscaling_group.name}"
  }
  actions_enabled = true
  alarm_actions = ["${aws_autoscaling_policy.autoscaling_policy_down.arn}"]
}
