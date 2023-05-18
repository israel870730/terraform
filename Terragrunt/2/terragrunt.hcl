remote_state {
  backend = "s3"

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    encrypt = true
    bucket = local.remote_bucket
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "my-modular-infrastructure-terraform-locks"
    profile = local.profile
    skip_bucket_versioning = false
    s3_bucket_tags = local.common_tags
    dynamodb_table_tags = local.common_tags
  }
}

locals {
  remote_bucket = format("javier-estrada-tutorial-%s-terraform-state", get_env("env", "dev"))
  profile = "tutorial"
  aws_region = "eu-west-1"
  common_tags = {
    Terraform : "true"
    Environment : get_env("env", "dev")
  }
}

inputs = {
  aws_region = local.aws_region
}


terraform {
  extra_arguments "aws_profile" {
    commands = get_terraform_commands_that_need_vars()
    env_vars = {
      AWS_PROFILE = local.profile,
      AWS_REGION = local.aws_region
    }
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = "eu-west-1"
}
EOF
}