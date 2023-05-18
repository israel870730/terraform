data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
    command     = "aws"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "default_public" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_subnet_ids" "default_private" {
  vpc_id = data.aws_vpc.selected.id
}

locals {  
  default     = {
    eks-poc-test = {
      desired_size = 2
      min_size     = 2
      max_size     = 5

      labels = {
        role = "general"
      }

      instance_types = ["t3.micro"]
      capacity_type  = "ON_DEMAND"
    }
  }
}

module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "18.29.0"
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access 
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  vpc_id                          = var.vpc_id == "" ? data.aws_vpc.selected.id : var.vpc_id
  subnet_ids                      = var.subnets == null ? concat(tolist(data.aws_subnet_ids.default_public.ids), tolist(data.aws_subnet_ids.default_private.ids)) : var.subnets
  enable_irsa                     = var.enable_irsa
  eks_managed_node_groups         = local.default
  manage_aws_auth_configmap       = var.manage_aws_auth_configmap
  aws_auth_roles                  = [ for aws_auth_role in var.aws_auth_roles : aws_auth_role ]
  cluster_enabled_log_types       = var.cluster_enabled_log_types
  tags                            = var.tags
}
