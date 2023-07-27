remote_state {
  backend = "s3"
  config = {
    bucket = "newpoc-state-20221226"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "newpoc-state-20221226"
  }
}

terraform {
  after_hook "copy_common_providers" {
    commands = ["init-from-module"]
    execute  = ["cp", "${get_parent_terragrunt_dir()}/../common/common_providers.tf", "."]
  }

  after_hook "copy_common_variables" {
    commands = ["init-from-module"]
    execute  = ["cp", "${get_parent_terragrunt_dir()}/../common/common_variables.tf", "."]
  }
}
