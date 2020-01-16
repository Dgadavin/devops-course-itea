data "template_file" "FluentServiceTemplate" {
  template = "${file("./templates/task_definition.json")}"

  vars {
    aws_region   = "us-east-1"
    docker_image = "644239850139.dkr.ecr.us-east-1.amazonaws.com/fluentd:1.0"
    service_name = "${var.service_name}"
    elk_url      = "vpc-tf-logging-elastic-dev-cfdts3bsqszdnh3yj4nbpdqrem.us-east-1.es.amazonaws.com"
  }
}
