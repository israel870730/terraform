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

resource "aws_kms_key" "this" {
  count                   = var.create_key ? 1 : 0
  description             = var.key_description
  deletion_window_in_days = var.key_deletion_window
  enable_key_rotation     = var.key_enable_rotation
  is_enabled              = var.key_enabled
  policy                  = var.policy == "" ? null : var.policy
  tags                    = merge(var.tags, local.common_tags)
}

resource "aws_kms_alias" "this" {
  count         = var.create_alias ? 1 : 0
  name          = var.alias_name == "renovite-key" ? format("alias/%s-%s", var.alias_name, random_string.alias_name.result) : var.alias_name
  target_key_id = var.alias_target_key_id == "" ? aws_kms_key.this[0].key_id : var.alias_target_key_id
}

resource "aws_kms_grant" "this" {
  count             = var.create_grant ? 1 : 0
  grantee_principal = var.grant_principal
  key_id            = aws_kms_key.this[0].key_id
  operations        = var.grant_operations
}

resource "random_string" "alias_name" {
  length  = 8
  special = false
}