output "cloudfront-dns-name" {
  value = "${aws_route53_record.www.fqdn}"
}
