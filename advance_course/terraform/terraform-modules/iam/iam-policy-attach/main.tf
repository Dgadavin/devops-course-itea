variable "iam_role_name" {}
variable "policy_arn" {}

resource "aws_iam_role_policy_attachment" "policy_atachment" {
   role       = "${var.iam_role_name}"
   policy_arn = "${var.policy_arn}"
}
