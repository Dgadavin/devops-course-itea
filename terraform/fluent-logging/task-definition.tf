data "template_file" "FluentServiceTemplate" {
  template = "${file("./templates/task_definition.json")}"

  vars {
    aws_region = "eu-west-1"
    docker_image = "644239850139.dkr.ecr.eu-west-1.amazonaws.com/service/fluentd-itea:1.0"
    service_name = "${var.service_name}"
    elk_url = "vpc-itea-test-geot7qxw6xi7gppyxices4qkte.eu-west-1.es.amazonaws.com"
  }
}
