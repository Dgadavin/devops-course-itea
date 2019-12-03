# resource "aws_security_group" "instance-sg" {
#   name   = "test-itea-sg"
#   vpc_id = "${var.vpc_id}"
#   ingress {
#     from_port         = 22
#     to_port           = 22
#     protocol          = "TCP"
#     cidr_blocks       = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port         = 0
#     to_port           = 0
#     protocol          = "-1"
#     cidr_blocks       = ["0.0.0.0/0"]
#   }
#   tags {
#     environment = "dev"
#   }
# }
