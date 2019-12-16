variable "alb_name" {}
variable "is_internal" { default = true }
variable "environment" {}
variable "subnet_ids" { type = "list" }
variable "security_group" { type = "list" }
variable "certificate_arn" {}
