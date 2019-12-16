module "ecs-service-role" {
  source       = "../terraform-modules/iam/iam-role"
  service_name = "${title(var.environment)}ClusterEcsService"
  trusted_name = "ecs"
}

module "autoscaling-role" {
  source       = "../terraform-modules/iam/iam-role"
  service_name = "${title(var.environment)}ClusterEcsAutoscaling"
  trusted_name = "ecs"
}

module "instance-role" {
  source           = "../terraform-modules/iam/iam-role"
  service_name     = "${title(var.environment)}ClusterInstanceRole"
  trusted_name     = "ec2"
  instance_profile = true
}

module "asg-lifeccycle-hook-role" {
  source       = "../terraform-modules/iam/iam-role"
  service_name = "${title(var.environment)}ClusterLifecycleHook"
  trusted_name = "autoscaling"
}

module "instance-role-policy" {
  source       = "../terraform-modules/iam/iam-policy"
  service_name = "${title(var.environment)}InstanceRolePolicy"
  description  = "Policy for ecs instances"

  policy_data = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "es:*",
                "ec2:Describe*",
                "ecs:StartTelemetrySession",
                "autoscaling:CompleteLifecycleAction",
                "autoscaling:DeleteLifecycleHook",
                "autoscaling:DescribeLifecycleHooks",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:PutLifecycleHook",
                "autoscaling:RecordLifecycleActionHeartbeat"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}

module "instance-policy-attachment" {
  source        = "../terraform-modules/iam/iam-policy-attach"
  iam_role_name = "${module.instance-role.IAMRoleName}"
  policy_arn    = "${module.instance-role-policy.PolicyARN}"
}

module "asg-lifeccycle-hook-policy-attachment" {
  source        = "../terraform-modules/iam/iam-policy-attach"
  iam_role_name = "${module.asg-lifeccycle-hook-role.IAMRoleName}"
  policy_arn    = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

module "instance-container-policy-attachment" {
  source        = "../terraform-modules/iam/iam-policy-attach"
  iam_role_name = "${module.instance-role.IAMRoleName}"
  policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

module "ecs-service-policy-attachment" {
  source        = "../terraform-modules/iam/iam-policy-attach"
  iam_role_name = "${module.ecs-service-role.IAMRoleName}"
  policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

module "autoscaling-policy-attachment" {
  source        = "../terraform-modules/iam/iam-policy-attach"
  iam_role_name = "${module.autoscaling-role.IAMRoleName}"
  policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
