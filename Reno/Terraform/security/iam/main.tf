terraform {
  required_version = ">= 0.13
}

locals {
  common_tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}


module "this_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "2.1.0"

  create_iam_access_key         = var.create_access_key
  create_iam_user_login_profile = var.create_user_login_profile
  create_user                   = var.create_user
  name                          = var.user_name
  tags                          = merge(var.user_tags, local.common_tags)
}

module "this_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "2.1.0"

  description = var.policy_description
  name        = var.policy_name
  path        = var.policy_path
  policy      = var.policy
}

module "this_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "2.1.0"

  create_role             = var.create_role
  custom_role_policy_arns = concat(list(module.this_policy.arn), var.custom_role_policy_arn)
  role_name               = var.role_name
  role_path               = var.role_path
  role_requires_mfa       = var.role_requires_mfa
  trusted_role_arns       = concat(list(module.this_user.this_iam_user_arn), var.trusted_role_arns)
  tags                    = merge(var.role_tags, local.common_tags)
}