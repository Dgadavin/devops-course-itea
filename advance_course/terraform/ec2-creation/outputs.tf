output "InstancePublicIP" {
  value = "${aws_instance.web.public_ip}"
}
