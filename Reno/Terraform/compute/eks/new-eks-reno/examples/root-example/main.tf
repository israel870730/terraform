locals {
  map_users = {
    userarn  = "arn:aws:iam::114712064551:user/israel.garcia@verifone.com"
    username = "israel.garcia@verifone.com"
    groups   = ["system:masters"]
  }

  worker_group = {
    instance_type = "t3.small"
     asg_desired_capacity = 3
    asg_max_size         = 3
    asg_min_size         = 3
    instance_type        = "t3.medium"
    #ami_id               = "ami-08024bd0a9ae5cb5a"
    #key_name             = ""
  }
}

module "eks" {
  source = "../../"

  cluster_name    = var.cluster_name
  map_users       = [local.map_users]
  use_default_vpc = true
  worker_groups   = [local.worker_group]
}
