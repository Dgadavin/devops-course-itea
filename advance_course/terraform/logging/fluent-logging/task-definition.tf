data "template_file" "FluentServiceTemplate" {
  template = "${file("./templates/task_definition.json")}"

  vars {
    aws_region   = "us-east-1"
    docker_image = ""
    service_name = "${var.service_name}"
    elk_url      = ""
  }
}
