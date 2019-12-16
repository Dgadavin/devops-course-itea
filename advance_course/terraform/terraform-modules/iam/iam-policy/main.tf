variable "service_name" {}
variable "description" {}
variable "policy_data" {}

resource "aws_iam_policy" "policy" {
  name        = "${var.service_name}-policy"
  path        = "/"
  description = "${var.description}"

  policy = "${var.policy_data}"
}

output "PolicyARN" {
  value = "${aws_iam_policy.policy.arn}"
}
