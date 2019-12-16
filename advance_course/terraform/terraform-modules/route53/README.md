# Create route53 alias record module

This module will create:
- Route53 Alias record for ALB

### Inputs

| Name  | Description  | Type  | Default  | Required  |
|---|---|---|---|---|
| elb_dns_name | DNS name of your service | string |  | yes |
| domain_hosted_zone_id | Route53 domain hosted zone ID | string |  | yes |
| load_balancer_dns_name | DNS name of ALB | string | | yes |
| canonical_hosted_zone_id | Hosted zone ID for ALB | string | | no |
| dns_create | Trigger for creating DNS record | boolean | true | no |

### Outputs

| Name  | Description |
|---|---|
| FancyLoadBalancerDNSName | DNS endpoint |
