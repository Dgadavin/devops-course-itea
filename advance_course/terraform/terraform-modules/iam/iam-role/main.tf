variable "service_name" {}
variable "trusted_name" {}
variable "instance_profile" { default = false }

data "template_file" "trusted_policy" {
  template = "${file("${path.module}/trusted_policy.json")}"
    vars {
      trusted_name = "${var.trusted_name}"
    }
}

resource "aws_iam_role" "iam_role" {
  name = "${var.service_name}-role"
  assume_role_policy = "${data.template_file.trusted_policy.rendered}"
}

resource "aws_iam_instance_profile" "instance_profile" {
  count = "${var.instance_profile}"
  name = "${var.service_name}-instance-profile"
  role = "${aws_iam_role.iam_role.name}"
}

output "IAMRoleARN" {
  value = "${aws_iam_role.iam_role.arn}"
}

output "IAMRoleName" {
  value = "${aws_iam_role.iam_role.name}"
}

output "InstanceProfileARN" {
  value = "${element(concat(aws_iam_instance_profile.instance_profile.*.arn, list("")), 0)}"
}

output "InstanceProfileName" {
  value = "${element(concat(aws_iam_instance_profile.instance_profile.*.name, list("")), 0)}"
}
