terraform {
  required_version = ">= 0.12"
}

locals {

  common_tags = {
    Terraform   = "true"
    Environment = var.environment
  }

}

data "aws_vpc" "default" {
  default = var.use_default_vpc
  tags    = var.vpc_tags
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
  tags   = var.use_default_vpc ? null : var.subnet_tags
}

data "aws_subnet" "default" {
  count = length(data.aws_subnet_ids.default.ids)
  id    = element(tolist(data.aws_subnet_ids.default.ids), count.index)
}

module "this" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.1.0"

  create                  = var.create
  ingress_rules           = var.ingress_rules
  ingress_cidr_blocks     = var.ingress_cidr_blocks == null ? data.aws_subnet.default.*.cidr_block : var.ingress_cidr_blocks
  egress_rules            = var.egress_rules
  egress_cidr_blocks      = var.egress_cidr_blocks == null ? data.aws_subnet.default.*.cidr_block : var.egress_cidr_blocks
  egress_ipv6_cidr_blocks = []
  name                    = var.security_group_name
  rules                   = var.rules
  tags                    = merge(var.tags, local.common_tags)
  use_name_prefix         = var.use_name_prefix
  vpc_id                  = data.aws_vpc.default.id
}