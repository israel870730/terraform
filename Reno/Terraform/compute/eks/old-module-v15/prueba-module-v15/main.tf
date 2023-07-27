##################################################################################
#  We define the backend that we are going to use to support the infrastructure  #
##################################################################################
terraform {
  backend "s3" {
    bucket = "state-terraform-poc-reno"
    key    = "env/reno/reno-dev3-cluster.tfstate"
    region = "us-east-1"

    dynamodb_table = "state-terraform-poc-reno-locks"
    encrypt        = true
  }
}

module "eks" {
  source = "../"

  cluster_name            = var.cluster_name
  cluster_version         = var.cluster_version
  map_users               = var.map_users
  vpc_id                  = var.vpc_id
  worker_groups           = var.worker_groups
  tags                    = var.tags
}
