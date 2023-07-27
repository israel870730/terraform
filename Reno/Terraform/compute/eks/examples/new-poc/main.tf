##################################################################################
#  We define the backend that we are going to use to support the infrastructure  #
##################################################################################
terraform {
  backend "s3"{
    bucket = "state-terraform-poc-reno"
    key    = "env/reno/eks-new-poc.tfstate"
    region =  "us-east-1"

    dynamodb_table = "state-terraform-poc-reno-locks"
    encrypt         = true 
  }
}

module "eks" {
  source = "../../poc"

  cluster_name              = var.cluster_name
  cluster_version           = var.cluster_version
  vpc_id                    = var.vpc_id
  eks_managed_node_groups   = var.eks_managed_node_groups
  aws_auth_roles            = var.aws_auth_roles
  aws_auth_users            = var.aws_auth_users
  tags                      = var.tags
}
