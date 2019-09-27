variable "vpc_cidr_range" {default = "10.0.0.0/16"}
variable "public_subnet_cidr" {default = "10.0.0.0/24"}
variable "private_subnet_cidr" {default = "10.0.10.0/24"}
variable "region" { default = "eu-west-1" }
variable "short_name" { default = "itea-test" }
variable "profile_name" { default = "glomex" } //only for instructor
variable "aws_access_key" {}
variable "aws_secret_key" {}
