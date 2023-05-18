terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git//modules/ssh?ref=v3.17.0"
    }

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
    config_path = "../../vpc"
    mock_outputs = {
    vpc_id = "vpc-mock"
  }
}

locals {
common_vars = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
name = "ssh-server-${local.common_vars.env}"
}

inputs = {
    name = local.name
    description = "Security group for ssh-server with ssh ports open within VPC"
    vpc_id = dependency.vpc.outputs.vpc_id

    ingress_cidr_blocks = ["10.10.0.0/16"]
    
}