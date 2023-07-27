terraform {
  required_version = ">= 0.12"
}

locals {
  default_availability_zone = format("%sa", data.aws_region.current.name)
  common_tags = {
    Terraform   = "true"
    Environment = "var.environment"
  }
}
data "aws_db_snapshot" "most_recent" {
  count                  = var.restore_from_snapshot ? 1 : 0
  db_instance_identifier = lookup(var.values, "identifier", var.defaults["identifier"])
  most_recent            = true
}

data "aws_region" "current" {}

data "aws_vpc" "default" {
  default = var.use_default_vpc
  tags    = var.vpc_tags
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
  tags   = var.use_default_vpc ? null : var.subnet_tags
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

module "this" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  allocated_storage           = lookup(var.values, "allocated_storage", var.defaults["allocated_storage"])
  allow_major_version_upgrade = lookup(var.values, "allow_major_version_upgrade", var.defaults["allow_major_version_upgrade"])
  auto_minor_version_upgrade  = lookup(var.values, "auto_minor_version_upgrade", var.defaults["auto_minor_version_upgrade"])
  availability_zone           = lookup(var.values, "multi_az", var.defaults["multi_az"]) == true ? null : lookup(var.values, "availability_zone", local.default_availability_zone)
  backup_window               = lookup(var.values, "backup_window", var.defaults["backup_window"])
  ca_cert_identifier          = lookup(var.values, "ca_cert_identifier", var.defaults["ca_cert_identifier"])
  deletion_protection         = lookup(var.values, "deletion_protection", var.defaults["deletion_protection"])
  engine                      = lookup(var.values, "engine", var.defaults["engine"])
  engine_version              = lookup(var.values, "engine_version", var.defaults["engine_version"])
  family                      = lookup(var.values, "family", var.defaults["family"])
  final_snapshot_identifier   = var.skip_final_snapshot ? null : format("%s-%s", var.final_snapshot_identifier, formatdate("YYYY-MM-DD-HH-mm", timestamp()))
  identifier                  = lookup(var.values, "identifier", var.defaults["identifier"])
  instance_class              = lookup(var.values, "instance_class", var.defaults["instance_class"])
  major_engine_version        = lookup(var.values, "major_engine_version", var.defaults["major_engine_version"])
  maintenance_window          = lookup(var.values, "maintenance_window", var.defaults["maintenance_window"])
  multi_az                    = lookup(var.values, "multi_az", var.defaults["multi_az"])
  option_group_name           = lookup(var.values, "option_group_name", var.defaults["option_group_name"])
  parameter_group_name        = lookup(var.values, "parameter_group_name", var.defaults["parameter_group_name"])
  password                    = lookup(var.values, "password", var.defaults["password"])
  port                        = lookup(var.values, "port", var.defaults["port"])
  skip_final_snapshot         = var.skip_final_snapshot
  snapshot_identifier         = var.restore_from_snapshot ? coalesce(var.snapshot_identifier, data.aws_db_snapshot.most_recent.0.id) : null
  storage_encrypted           = lookup(var.values, "storage_encrypted", var.defaults["storage_encrypted"])
  subnet_ids                  = lookup(var.values, "subnet_ids", data.aws_subnet_ids.default.ids)
  tags                        = merge(var.tags, local.common_tags)
  timezone                    = lookup(var.values, "timezone", var.defaults["timezone"])
  username                    = lookup(var.values, "username", var.defaults["username"])
  vpc_security_group_ids      = lookup(var.values, "vpc_security_group_ids", list(module.this_sg.security_group_id))
}

module "this_sg" {
  source = "../../network/security-groups"


  create              = var.create_security_group
  ingress_rules       = ["mysql-tcp"]
  egress_rules        = ["mysql-tcp"]
  security_group_name = "default-mysql-access"
  subnet_tags         = var.private_subnet_tags
  use_default_vpc     = var.use_default_vpc
  vpc_tags            = var.use_default_vpc ? null : var.vpc_tags
  rules               = {
    "mysql-tcp" : [
      lookup(var.values, "port", var.defaults["port"]),
      lookup(var.values, "port", var.defaults["port"]),
      "tcp",
      "MySQL/Aurora"
    ]
  }
}