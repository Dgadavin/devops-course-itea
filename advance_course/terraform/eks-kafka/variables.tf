#Immutable variables
variable "service_name" { default = "k8s" }
variable "Environment" {}
#Common variables
variable "workers_instance_type" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "vpc_id" {}
variable "subnet_id" {}
