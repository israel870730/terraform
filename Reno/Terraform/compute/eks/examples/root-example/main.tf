locals {
  map_users = {
    userarn  = "arn:aws:iam::114712064551:user/israel.garcia@verifone.com"
    username = "israel.garcia@verifone.com"
    groups   = "system:masters"
  }

  worker_group = {
    instance_type = "t3.small"
    spot_price    = "0.03"
  }
}

module "eks" {
  source = "../../old"

  cluster_name    = var.cluster_name
  map_users       = [local.map_users]
  use_default_vpc = true
  worker_groups   = [local.worker_group]
}
