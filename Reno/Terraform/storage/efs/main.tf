terraform {
  required_version = "~> 0.13.0"

  required_providers {
    aws = "~> 2.0"
  }
}

locals {
  common_tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

data "aws_vpc" "default_vpc" {
  default = var.use_default_vpc
  tags    = var.vpc_tags
}
data "aws_subnet_ids" "default_subnets" {
  vpc_id = data.aws_vpc.default_vpc.id
  tags   = var.use_default_vpc ? null : var.subnet_tags
}

resource "aws_efs_file_system" "this" {
  encrypted = var.efs_encrypted
  tags      = merge(map("Name", var.efs_name), var.tags, local.common_tags)

}
resource "aws_efs_mount_target" "this" {
  count          = length(data.aws_subnet_ids.default_subnets.ids)
  file_system_id = aws_efs_file_system.this.id
  subnet_id      = element(tolist(data.aws_subnet_ids.default_subnets.ids), count.index)

  security_groups = var.create_security_group ? concat(var.efs_security_group_ids, list(module.this_sg.security_group_id)) : var.efs_security_group_ids
}

module "this_sg" {
  source = "../../network/security-groups"

  create              = var.create_security_group
  ingress_rules       = ["nfs-tcp"]
  egress_rules        = ["nfs-tcp"]
  security_group_name = "default-efs-access"
  subnet_tags         = var.subnet_tags
  use_default_vpc     = var.use_default_vpc
  vpc_tags            = var.use_default_vpc ? null : var.vpc_tags
}