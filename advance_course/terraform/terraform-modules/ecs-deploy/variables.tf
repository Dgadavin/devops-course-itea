variable "service_name" {}
variable "app_autoscaling_enabled" { default = 1 }
variable "lb_enabled" { default = 1 }
variable "container_name" {}
variable "cluster_id" {}
variable "task_definition_arn" {}
variable "desire_count" { default = 2 }
variable "service_iam_role" { default = "" }
variable "deployment_maximum_percent" { default = 200 }
variable "deployment_minimum_healthy_percent" { default = 100 }
variable "container_port" { default = 80 }
variable "scale_max_capacity" {}
variable "scale_min_capacity" {}
variable "scale_out_threshold" { default = 65 }
variable "scale_in_threshold" { default = 10 }
variable "scale_out_cooldown_period" { default = 60 }
variable "scale_in_cooldown_period" { default = 60 }
variable "scale_out_adjustment" { default = 2 }
variable "scale_in_adjustment" { default = -2 }
variable "autoscaling_iam_role_arn" { default = "" }
variable "task_spread_strategy" { default = "default" }
variable "scheduling_strategy" { default = "REPLICA" }
# Target group vars
variable "tg_port" { default = 80 }
variable "vpc_id" { default = "" }
variable "health_path" { default = "/" }
variable "health_check_interval" { default = 60 }
variable "health_check_timeout" { default = 5 }
variable "health_check_healthy_threshold" { default = 3 }
variable "health_check_unhealthy_threshold" { default = 3 }
variable "http_listener_arn" { default = "" }
variable "https_listener_arn" { default = "" }
variable "response_code" { default = "200" }
# DNS vars
variable "route53_fqdn" { default = "" }
