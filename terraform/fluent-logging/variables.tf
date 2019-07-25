variable "profile_name" { default = "glomex" }
variable "ami_id" {}

variable "aws_access_key" {}
variable "service_name" { default = "fluentd-logs" }
variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "cluster_id" { default = "itea-devops-dev" }