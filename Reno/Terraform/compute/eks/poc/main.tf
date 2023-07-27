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
  tags   = var.public_subnet_tags
}

data "aws_subnet_ids" "default_private" {
  vpc_id = data.aws_vpc.selected.id
  tags   = var.private_subnet_tags
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
  # Default for all node groups
  #Aqui defino los valores predeterminado que van a tener todos los "eks_managed_node_groups"
  #
  eks_managed_node_group_defaults = {
    desired_size = 2
    min_size     = 2
    max_size     = 5

    ami_id = "ami-0edd73fffdd8574b5"
    enable_bootstrap_user_data = true

    #capacity_type    = "SPOT"       # default spot instance
    eni_delete       = true         # delete eni on termination
    #key_name         = local.key    # default ssh keypair for nodes
    ebs_optimized    = true         # ebs optimized instance
    ami_type         = "AL2_x86_64" # default ami type for nodes
    create_launch_template  = true
    enable_monitoring       = true
    update_default_version  = false  # set new LT ver as default

    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size           = 25
          volume_type           = "gp3"
          iops                  = 3000
          throughput            = 150
          #encrypted             = true
          #kms_key_id            = module.ebs_kms_key.key_arn
          delete_on_termination = true
        }
      }
    }

    # Subnets to use (Recommended: Private Subnets)
    subnets          = data.aws_subnet_ids.default_public.ids

    # user data for LT
    pre_userdata = ""

    update_config = {
      max_unavailable_percentage = 10 # or set `max_unavailable`
    }
  }
  worker_groups         = [for worker_group in local.worker_groups : merge(local.default_worker_group, worker_group)]
  eks_managed_node_groups         = var.eks_managed_node_groups
  manage_aws_auth_configmap       = var.manage_aws_auth_configmap
  aws_auth_roles                  = [ for aws_auth_role in var.aws_auth_roles : aws_auth_role ]
  aws_auth_users                  = [ for aws_auth_user in var.aws_auth_users : aws_auth_user ]
  cluster_enabled_log_types       = var.cluster_enabled_log_types
  tags                            = var.tags
}
