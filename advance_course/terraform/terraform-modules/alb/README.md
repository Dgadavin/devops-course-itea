## Create Application load balancer module

This module will create:
- Application load balancer
- HTTP and HTTPS listeners
- Target group for default rule

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| alb_name | Name of the Load Balancer | string |  | yes |
| is_internal | Provide false for Internet facing Load Balancer | boolean | true | no |
| environment | Environment | string | | yes |
| subnet_ids | IDs of subnets | list |  | yes |
| security_group | Security group for Load Balancer | string | | yes |
| certificate_arn | ARN of the certificate from AWS certificate manager | sting | | yes |

### Outputs

| Name  | Description |
|---|---|
| ApplicationLoadBalancer | The load balancer ARN |
| ApplicationLoadBalancerDNSName | The DNS name for the load balancer |
| ApplicationLoadBalancerFullName | The full name of the load balancer |
| ApplicationLoadBalancerHttpListener | HTTP listener ARN |
| ApplicationLoadBalancerHttpsListener | HTTPS listener ARN |

### Example

```hcl
module "alb-internal" {
  source = "../terraform-modules//alb"
  vpc_id = "${var.VPCId}"
  alb_name = "${var.ClusterName}-internal"
  subnet_ids = "${var.SubnetIds}"
  environment = "${var.Environment}"
  certificate_arn = "${var.CertificateARN}"
  security_group = "${aws_security_group.internal-load-balancer.id}"
}
```
