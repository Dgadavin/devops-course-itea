variable "topic_name" {}

resource "aws_sns_topic" "sns" {
  name = "${var.topic_name}"
}
output "SNSTopicARN" {
  value = "${aws_sns_topic.sns.arn}"
}
