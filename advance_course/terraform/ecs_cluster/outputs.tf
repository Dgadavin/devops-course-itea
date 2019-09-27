output "IAMRoleARN" {
  value = "${aws_iam_role.instance-role.arn}"
}

output "IAMRoleName" {
  value = "${aws_iam_role.instance-role.name}"
}