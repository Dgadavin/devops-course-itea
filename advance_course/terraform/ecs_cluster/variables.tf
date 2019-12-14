variable "profile_name" {
  default = "glomex"
}

variable "ami_id" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "VPCId" {}

variable "subnet_ids" {
  type = "list"
}

variable "ClusterName" {
  default = "itea-devops"
}

variable "Environment" {
  default = "dev"
}
