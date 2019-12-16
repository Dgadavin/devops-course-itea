provider "aws" {
  region     = "us-east-1"
}

provider "random" {
}

terraform {
  backend "s3" {}
}
