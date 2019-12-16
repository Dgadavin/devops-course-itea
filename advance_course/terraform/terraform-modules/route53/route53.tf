variable "elb_dns_name" {}
variable "domain_hosted_zone_id" {}
variable "load_balancer_dns_name" {}
variable "canonical_hosted_zone_id" {}
variable "dns_create" { default = true }

resource "aws_route53_record" "AliasRecord" {
  count = "${var.dns_create ? 1 : 0}"
  zone_id = "${var.domain_hosted_zone_id}"
  name    = "${var.elb_dns_name}"
  type    = "A"
  alias {
    name                   = "${var.load_balancer_dns_name}"
    zone_id                = "${var.canonical_hosted_zone_id}"
    evaluate_target_health = true
  }
}

output "FancyLoadBalancerDNSName" {
  value = "${ join(" ", aws_route53_record.AliasRecord.*.fqdn) }"

}
