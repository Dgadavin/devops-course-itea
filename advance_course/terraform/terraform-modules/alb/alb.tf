resource "aws_alb" "alb" {
  name            = "${var.alb_name}"
  subnets         = ["${var.subnet_ids}"]
  security_groups = ["${var.security_group}"]
  internal         = "${var.is_internal}"

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "HEALTHY"
      status_code = "200"
    }
  }
}

# resource "aws_alb_listener" "https" {
#   load_balancer_arn = "${aws_alb.alb.id}"
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "${var.certificate_arn}"
#
#   default_action {
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "HEALTHY"
#       status_code = "200"
#     }
#   }
# }
