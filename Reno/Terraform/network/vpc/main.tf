terraform {
  required_version = ">= 0.13"
}

locals {
  common_tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

data "aws_availability_zones" "available" {}

module "this" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.7.0"

  azs                    = var.availability_zones == [] ? var.availability_zones : data.aws_availability_zones.available.names
  cidr                   = var.vpc_base_cidr
  enable_nat_gateway     = var.enable_nat_gateway
  enable_vpn_gateway     = var.enable_vpn_gateway
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support     = var.enable_dns_support
  database_subnets       = split(",", var.isolated_subnets)
  database_subnet_tags   = merge(var.isolated_subnet_tags, local.common_tags)
  name                   = var.vpc_name
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  private_subnets        = split(",", var.private_subnets)
  private_subnet_tags    = merge(var.private_subnet_tags, local.common_tags)
  public_subnets         = split(",", var.public_subnets)
  public_subnet_tags     = merge(var.public_subnet_tags, local.common_tags)
  tags                   = merge(var.vpc_tags, local.common_tags)
}
