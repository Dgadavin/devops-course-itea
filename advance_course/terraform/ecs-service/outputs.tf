output "InternaServiceDNSName" {
  value = "${module.route53-internal.FancyLoadBalancerDNSName}"
}
