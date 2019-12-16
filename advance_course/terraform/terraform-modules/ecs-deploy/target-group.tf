resource "aws_lb_target_group" "TargetGroup" {
  count = "${var.lb_enabled ? 1 : 0}"
  name     = "${var.service_name}-tg"
  port     = "${var.tg_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  deregistration_delay = 10
  health_check {
    path = "${var.health_path}"
    interval = "${var.health_check_interval}"
    timeout = "${var.health_check_timeout}"
    healthy_threshold = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    matcher = "${var.response_code}"
  }
}

resource "random_integer" "priority" {
  count = "${var.lb_enabled ? 1 : 0}"
  min     = 1
  max     = 50000
}

resource "aws_lb_listener_rule" "HTTPListener" {
  count = "${var.lb_enabled ? 1 : 0}"
  listener_arn = "${var.http_listener_arn}"
  priority     = "${random_integer.priority.result}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.TargetGroup.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${var.route53_fqdn}"]
  }
}

# resource "aws_lb_listener_rule" "HTTPSListener" {
#   count = "${var.lb_enabled ? 1 : 0}"
#   listener_arn = "${var.https_listener_arn}"
#   priority     = "${random_integer.priority.result}"
#
#   action {
#     type             = "forward"
#     target_group_arn = "${aws_lb_target_group.TargetGroup.arn}"
#   }
#
#   condition {
#     field  = "host-header"
#     values = ["${var.route53_fqdn}"]
#   }
# }
