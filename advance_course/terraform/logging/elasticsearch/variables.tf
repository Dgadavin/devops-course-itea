#Immutable variables
variable "service_name" {
  default = "logging-elastic"
}

variable "Environment" {}

#Common variables
variable "ESInstanceCount" {}

variable "ESVersion" {}
variable "ElasticEBSize" {}
variable "ESInstanceType" {}
variable "main_cluster_stack_name" {}
variable "vpc_id" {}
variable "subnet_id" {}
