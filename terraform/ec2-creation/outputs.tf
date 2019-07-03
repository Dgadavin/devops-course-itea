output "IAMRoleARN" {
  value = "${aws_iam_role.instance-role.arn}"
}

output "IAMRoleName" {
  value = "${aws_iam_role.instance-role.name}"
}

output "EC2PrivateIP" {
  value = "${aws_instance.web.private_ip}"
}