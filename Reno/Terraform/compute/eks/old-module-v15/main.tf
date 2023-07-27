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
  load_config_file       = false
  version                = "~> 1.12"
}


data "aws_subnet_ids" "default_public" {
  vpc_id = var.vpc_id
  tags   = var.use_default_vpc ? null : var.public_subnet_tags
}

data "aws_subnet_ids" "default_private" {
  vpc_id = var.vpc_id
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
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "true"
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
    kubelet_extra_args   = "--node-labels=node.kubernetes.io/lifecycle=spot"
    kubelet_node_labels  = ""
    suspended_processes  = tolist(["AZRebalance"])
    subnets              = var.workgroup_subnets == null ? data.aws_subnet_ids.default_private.ids : var.workgroup_subnets
  }
}

module "this" {
  source  = "terraform-aws-modules/eks/aws"
  version = "15.0.0"
  manage_cluster_iam_resources = var.manage_cluster_iam_resources
  manage_worker_iam_resources  = var.manage_worker_iam_resources
  cluster_iam_role_name        = var.cluster_iam_role_name
  workers_role_name            = var.workers_role_name
  worker_ami_owner_id   = "amazon"
  worker_ami_owner_id_windows = "amazon"
  cluster_name          = var.cluster_name
  cluster_version       = var.cluster_version
  config_output_path    = var.config_output_path
  manage_aws_auth       = var.manage_aws_auth
  subnets               = var.subnets == null ? concat(tolist(data.aws_subnet_ids.default_public.ids), tolist(data.aws_subnet_ids.default_private.ids)) : var.subnets
  tags                  = merge(var.tags, local.common_tags)
  vpc_id                = var.vpc_id
  write_kubeconfig      = var.write_kubeconfig
  worker_groups         = [for worker_group in local.worker_groups : merge(local.default_worker_group, worker_group)]
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  map_users             = var.map_users
  map_roles             = var.map_roles
  enable_irsa           = true
}