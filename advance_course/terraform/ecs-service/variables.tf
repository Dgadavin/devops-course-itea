#Immutable variables
variable "service_name" {
  default = "itea-nginx"
}

variable "Environment" {}
variable "commit_hash" {}

#Common variables
variable "main_cluster_stack_name" {}

variable "vpc_id" {}

variable "ScaleMinCapacity" {
  default = "1"
}

variable "ScaleMaxCapacity" {
  default = "1"
}

variable "HostedZone" {}
variable "HostedZoneID" {}
variable "ELBDNSName" {}
