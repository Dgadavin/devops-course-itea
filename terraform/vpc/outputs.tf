output "subnet_ids_public" {
  value = "${aws_subnet.public.id}"
}

output "subnet_ids_private" {
  value = "${aws_subnet.private.id}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "default_security_group" {
  value = "${aws_vpc.main.default_security_group_id}"
}
