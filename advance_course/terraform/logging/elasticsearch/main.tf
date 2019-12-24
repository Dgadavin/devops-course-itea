data "terraform_remote_state" "main-cluster" {
  backend = "s3"

  config = {
    bucket = "my-state-test-bucket-1"
    key    = "${var.main_cluster_stack_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_security_group" "allow_ecs_cluster_to_es" {
  name        = "${var.main_cluster_stack_name}-to-es"
  description = "Allow ES access for to communicate with ${var.main_cluster_stack_name}"
  vpc_id      = "${var.vpc_id}"

  ingress = {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"

    security_groups = [
      "${data.terraform_remote_state.main-cluster.ClusterSecurityGroup}",
    ]
  }
}

module "es_with_vpc" {
  source                         = "github.com/terraform-community-modules/tf_aws_elasticsearch?ref=v0.8.0"
  domain_name                    = "${var.service_name}-${var.Environment}"
  es_version                     = "${var.ESVersion}"
  create_iam_service_linked_role = "${var.Environment == "dev" ? true : false}"

  vpc_options = {
    security_group_ids = ["${aws_security_group.allow_ecs_cluster_to_es.id}"]
    subnet_ids         = ["${var.subnet_id}"]
  }

  instance_count  = "${var.ESInstanceCount}"
  instance_type   = "${var.ESInstanceType}"
  ebs_volume_size = "${var.ElasticEBSize}"
}
