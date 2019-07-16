resource "aws_route53_record" "www" {
  zone_id = "${var.route53_zone_id}"
  name    = "${var.cloudfront_cname}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_cloudfront_distribution.default.domain_name}"]
}
