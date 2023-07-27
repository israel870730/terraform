terraform {
  required_version = ">= 0.13"
}

data "aws_eks_cluster" "cluster" {
  name = module.this.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.this.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = var.load_config_file
  version                = "~> 1.12"
}

data "aws_vpc" "default" {
  //default = var.use_default_vpc
  //tags    = var.vpc_tags
  id = var.vpc_id
}

data "aws_subnet_ids" "default_public" {
  vpc_id = data.aws_vpc.default.id
  tags   = var.use_default_vpc ? null : var.public_subnet_tags
}

data "aws_subnet_ids" "default_private" {
  vpc_id = data.aws_vpc.default.id
  tags   = var.use_default_vpc ? null : var.private_subnet_tags
}

data "aws_subnet" "private_subnets" {
  for_each = data.aws_subnet_ids.default_private.ids
  id       = each.key
}

locals {
  common_tags = {
    Terraform   = "true"
    Environment = var.environment
  }

  lifecycle = {
    spot = {
      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
    }
    ondemand = {
      kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=ondemand"
    }
  }

  worker_groups = [for worker_group in var.worker_groups : merge(local.lifecycle[lookup(worker_group, "spot_price", null) == null ? "ondemand" : "spot"], worker_group)]

  default_worker_group = {
    additional_userdata  = "sudo sed -i 's/nofile=1024:4096/nofile=65536:65536/g' /etc/sysconfig/docker && sudo service docker restart"
    asg_desired_capacity = 3
    asg_max_size         = 3
    asg_min_size         = 3
    autoscaling_enabled  = true
    instance_type        = "t3.xlarge"
    name                 = "wg-"
    #ami_id               = "ami-08024bd0a9ae5cb5a"
    #key_name             = ""
    kubelet_node_labels  = ""
    suspended_processes  = list("AZRebalance")
    subnets              = var.workgroup_subnets == null ? data.aws_subnet_ids.default_private.ids : var.workgroup_subnets
  }
}

module "this" {
  source  = "terraform-aws-modules/eks/aws"
  version = "13.0.0"

  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  config_output_path = var.config_output_path
  manage_aws_auth    = var.manage_aws_auth
  map_users          = var.map_users
  map_roles          = var.map_roles
  subnets            = var.subnets == null ? concat(tolist(data.aws_subnet_ids.default_public.ids), tolist(data.aws_subnet_ids.default_private.ids)) : var.subnets
  tags               = merge(var.tags, local.common_tags)
  vpc_id             = var.vpc_id == "" ? data.aws_vpc.default.id : var.vpc_id
  write_kubeconfig   = var.write_kubeconfig
  worker_groups      = [for worker_group in local.worker_groups : merge(local.default_worker_group, worker_group)]
  worker_ami_owner_id = "amazon"
}