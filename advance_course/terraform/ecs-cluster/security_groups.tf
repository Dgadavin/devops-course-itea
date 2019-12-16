resource "aws_security_group" "internal-load-balancer" {
  name   = "${title(var.environment)}InternalLoadBalancerSG"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    environment = "${var.environment}"
  }
}

resource "aws_security_group" "external-load-balancer" {
  name   = "${title(var.environment)}ExternalLoadBalancerSG"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    environment = "${var.environment}"
  }
}

resource "aws_security_group" "cluster-sg" {
  name   = "${title(var.environment)}ClusterSecurityGroup"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["10.1.0.0/16"]
  }

  ingress {
    from_port = 32768
    to_port   = 61000
    protocol  = "TCP"

    security_groups = ["${aws_security_group.external-load-balancer.id}",
      "${aws_security_group.internal-load-balancer.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "cluster-sg-self" {
  type                     = "ingress"
  from_port                = 32768
  to_port                  = 61000
  protocol                 = "TCP"
  source_security_group_id = "${aws_security_group.cluster-sg.id}"
  security_group_id        = "${aws_security_group.cluster-sg.id}"
}
