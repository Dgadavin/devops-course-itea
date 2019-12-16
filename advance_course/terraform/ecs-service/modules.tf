data "terraform_remote_state" "main-cluster" {
  backend = "s3"

  config = {
    bucket = "my-state-test-bucket-1"
    key    = "${var.main_cluster_stack_name}/terraform.tfstate"
    region = "us-east-1"
  }
}

module "task-definition" {
  source             = "git@github.com:dgadavin/itea-terraform-workshop//terraform-modules/task-definition"
  family             = "${var.service_name}-terraform"
  task_template      = "${data.template_file.nginxTemplate.rendered}"
  task_role_arn      = "${module.iam-role.IAMRoleARN}"
  execution_role_arn = "${module.iam-role.IAMRoleARN}"
}

module "route53-internal" {
  source                   = "git@github.com:dgadavin/itea-terraform-workshop//terraform-modules/route53"
  elb_dns_name             = "${var.ELBDNSName}-us-east-1"
  domain_hosted_zone_id    = "${var.HostedZoneID}"
  load_balancer_dns_name   = "${data.terraform_remote_state.main-cluster.ClusterInternetFacingLoadBalancerDNSName}"
  canonical_hosted_zone_id = "Z35SXDOTRQ7X7K"
}

module "ecs-service" {
  source                             = "git@github.com:dgadavin/itea-terraform-workshop//terraform-modules/ecs-deploy"
  service_name                       = "${var.service_name}-${lower(var.Environment)}"
  container_name                     = "${var.service_name}"
  vpc_id                             = "${var.vpc_id}"
  http_listener_arn                  = "${data.terraform_remote_state.main-cluster.ClusterInternetFacingLoadBalancerHttpListener}"
  cluster_id                         = "${data.terraform_remote_state.main-cluster.ClusterName}"
  task_definition_arn                = "${module.task-definition.TaskDefinitionARN}"
  desire_count                       = "${var.ScaleMinCapacity}"
  service_iam_role                   = "${data.terraform_remote_state.main-cluster.ClusterecsServiceRole}"
  scale_max_capacity                 = "${var.ScaleMaxCapacity}"
  scale_min_capacity                 = "${var.ScaleMinCapacity}"
  autoscaling_iam_role_arn           = "${data.terraform_remote_state.main-cluster.AutoscalingEcsRole}"
  route53_fqdn                       = "${module.route53-internal.FancyLoadBalancerDNSName}"
  health_path                        = "/"
  app_autoscaling_enabled            = false
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  container_port                     = 80
}
