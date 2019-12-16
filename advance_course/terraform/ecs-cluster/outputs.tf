output "ClusterName" {
  value = "${aws_ecs_cluster.ecs-cluster.name}"
}

output "ClusterARN" {
  value = "${aws_ecs_cluster.ecs-cluster.arn}"
}

output "DrainEcsTopic" {
  value = "${module.sns-drain-topic.SNSTopicARN}"
}

output "ClusterecsServiceRole" {
  value = "${module.ecs-service-role.IAMRoleARN}"
}

output "AutoscalingEcsRole" {
  value = "${module.autoscaling-role.IAMRoleARN}"
}

output "ClusterInternetFacingLoadBalancerFullName" {
  value = "${module.alb-external.ApplicationLoadBalancerFullName}"
}

output "ClusterInternetFacingLoadBalancerHttpListener" {
  value = "${module.alb-external.ApplicationLoadBalancerHttpListener}"
}

# output "ClusterInternetFacingLoadBalancerHttpsListener" {
#   value = "${module.alb-external.ApplicationLoadBalancerHttpsListener}"
# }

output "ClusterInternetFacingLoadBalancerDNSName" {
  value = "${module.alb-external.ApplicationLoadBalancerDNSName}"
}

output "ClusterInternalLoadBalancerFullName" {
  value = "${module.alb-internal.ApplicationLoadBalancerFullName}"
}

output "ClusterInternalLoadBalancerHttpListener" {
  value = "${module.alb-internal.ApplicationLoadBalancerHttpListener}"
}

# output "ClusterInternalLoadBalancerHttpsListener" {
#   value = "${module.alb-internal.ApplicationLoadBalancerHttpsListener}"
# }

output "ClusterInternalLoadBalancerDNSName" {
  value = "${module.alb-internal.ApplicationLoadBalancerDNSName}"
}

output "ClusterSecurityGroup" {
  value = "${aws_security_group.cluster-sg.id}"
}

output "InternalALBSecurityGroup" {
  value = "${aws_security_group.internal-load-balancer.id}"
}

output "ExternalALBSecurityGroup" {
  value = "${aws_security_group.external-load-balancer.id}"
}
