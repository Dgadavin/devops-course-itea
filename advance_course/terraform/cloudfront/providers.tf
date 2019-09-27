provider "aws" {
  profile    = "${var.profile_name}"
  region     = "eu-west-1"
}

provider "aws" {
  alias = "east"
  profile    = "${var.profile_name}"
  region     = "us-east-1"
}

provider "random" {
}

terraform {
  backend "s3" {}
}
