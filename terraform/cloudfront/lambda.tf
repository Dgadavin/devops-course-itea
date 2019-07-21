data "archive_file" "basic-auth" {
  type = "zip"
  source_file = "${path.module}/lambda_function/index.js"
  output_path = "${path.module}/lambda_function/index.zip"
}

resource "aws_lambda_function" "basic-auth-function" {
  provider = "aws.east"
  function_name = "${var.service_name}-basic-auth"
  filename = "${data.archive_file.basic-auth.output_path}"
  source_code_hash = "${data.archive_file.basic-auth.output_base64sha256}"
  role = "${aws_iam_role.basic-auth-role.arn}"
  runtime = "nodejs8.10"
  handler = "index.handler"
  memory_size = 128
  timeout = 3
  publish = true
}

data "aws_iam_policy_document" "basic-auth-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }
  }
}
resource "aws_iam_role" "basic-auth-role" {
  name = "${var.service_name}-lambda-role"
  assume_role_policy = "${data.aws_iam_policy_document.basic-auth-policy.json}"
}

resource "aws_iam_role_policy_attachment" "basic" {
  role = "${aws_iam_role.basic-auth-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
