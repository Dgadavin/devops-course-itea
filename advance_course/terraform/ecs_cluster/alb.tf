resource "aws_alb" "alb" {
  name            = "itea-devops-balncer"
  subnets         = "${var.subnet_ids}"
  security_groups = ["${aws_security_group.internal-load-balancer.id}"]
  internal        = false

  tags {
    Environment = "${var.Environment}"
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
      status_code  = "200"
    }
  }
}
