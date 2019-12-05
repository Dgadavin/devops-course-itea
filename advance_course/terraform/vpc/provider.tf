provider "aws" {
  profile    = "${var.profile_name}"
  region     = "eu-central-1"
}


// Provider for users with access and secret keys
//provider "aws" {
//  access_key = "${var.aws_access_key}"
//  secret_key = "${var.aws_secret_key}"
//  region     = "${var.aws_region}"
//}

//provider "random" {
//}
//
//terraform {
//  backend "s3" {}
//}
