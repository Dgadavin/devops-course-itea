#Immutable variables
variable "service_name" {
  default = "main-cluster"
}

variable "profile_name" {
  default = "itea"
}

variable "environment" {}

#Common variables
variable "ClusterName" {}

variable "CertificateARN" {
  default = ""
}

variable "AmiId" {
  default = "ami-0b84afb18c43907ba"
}

variable "ssh_key_name" {}

variable "subnet_ids" {
  type = "list"
}

variable "vpc_id" {}
