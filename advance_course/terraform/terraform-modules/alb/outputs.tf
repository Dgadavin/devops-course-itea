output "ApplicationLoadBalancer" {
  value = "${aws_alb.alb.arn}"
}

output "ApplicationLoadBalancerDNSName" {
  value = "${aws_alb.alb.dns_name}"
}

output "ApplicationLoadBalancerFullName" {
  value = "${aws_alb.alb.id}"
}

output "ApplicationLoadBalancerHttpListener" {
  value = "${aws_alb_listener.http.arn}"
}

# output "ApplicationLoadBalancerHttpsListener" {
#   value = "${aws_alb_listener.https.arn}"
# }
