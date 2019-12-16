variable "environment" {}
variable "name" {}
variable "aws_ami" {}
variable "security_groups" { type = "list" }
variable "instance_type" { default     = "t3.medium" }
variable "iam_instance_profile_arn" {}
variable "subnet_ids" { type = "list" }
variable "enable_monitoring" { default = "false"}
variable "volume_size" { default = "20" }
variable "scale_max_capacity" { default = "4" }
variable "scale_min_capacity" { default = "2" }
variable "desired_capacity" { default = "2" }
variable "availability_zones" { default = ["us-east-1b", "us-east-1c", "us-east-1a"]}
variable "notify_target" { default = "" }
variable "notify_role_arn" { default = "" }
variable "lifecycle_hook" { default = 1 }
variable "user_data" {}
variable "down_alarm_threshold" { default = "10" }
variable "up_alarm_threshold" { default = "80" }
variable "spot_price" { default = "" }
variable "ssh_key_name" {}
