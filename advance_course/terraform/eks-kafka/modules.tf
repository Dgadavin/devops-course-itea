module "my-cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = "itea-${lower(var.Environment)}-${var.service_name}"
  vpc_id       = var.vpc_id
  subnets = [var.subnet_id]
  workers_additional_policies = ["arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
                                 "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
                                 "arn:aws:iam::aws:policy/AmazonS3FullAccess"]

  worker_groups = [
    {
      asg_max_size  = var.max_size
      asg_desired_capacity = var.desired_capacity
      asg_min_size = var.min_size
      instance_type = var.workers_instance_type

    }
  ]
}
