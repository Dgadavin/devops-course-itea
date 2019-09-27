resource "aws_launch_configuration" "launch_configuration" {
  name_prefix          = "${var.name}"
  image_id             = "${var.aws_ami}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${var.security_groups}"]
  user_data            = "${var.user_data}"
  iam_instance_profile = "${var.iam_instance_profile_arn}"
  enable_monitoring    = "${var.enable_monitoring}"
  key_name             = "${var.key_name}"
  root_block_device {
      volume_size = "${var.volume_size}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                 = "${var.name}-${var.environment}"
  launch_configuration = "${aws_launch_configuration.launch_configuration.name}"
  max_size             = "${var.scale_max_capacity}"
  min_size             = "${var.scale_min_capacity}"
  desired_capacity     = "${var.desired_capacity}"
  availability_zones   = "${var.availability_zones}"
  vpc_zone_identifier  = "${var.subnet_ids}"
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key = "Name"
    value = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_lifecycle_hook" "autoscaling_lifecycle_hook" {
  count                  = "${var.lifecycle_hook ? 0 : 1}"
  name                   = "${var.name}-${var.environment}-lh"
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
  default_result         = "CONTINUE"
  heartbeat_timeout      = 900
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"

  notification_target_arn = "${var.notify_target}"
  role_arn                = "${var.notify_role_arn}"
}

resource "aws_autoscaling_policy" "autoscaling_policy_up" {
  name                   = "${var.name}-${var.environment}-ap-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
}

resource "aws_autoscaling_policy" "autoscaling_policy_down" {
  name = "${var.name}-${var.environment}-ap-down"
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}
