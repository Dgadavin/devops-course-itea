provider "aws" {
  region     = "eu-west-1"
}

# provider "random" {
# }
# //
terraform {
  backend "s3" {
  #   bucket = "terraform-dp-dev-state"
  #   key = "ec2/tf.state"
  #   # region = "us-east-2"
  # }
}
