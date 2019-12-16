data "template_file" "nginxTemplate" {
  template = "${file("./templates/task_definition.json")}"

  vars = {
    app_env = "${var.Environment}"
    app_internal_host = "${var.ELBDNSName}.${var.HostedZone}"
    docker_image = "nginx:${var.commit_hash}"
    service_name = "${var.service_name}"
  }
}
