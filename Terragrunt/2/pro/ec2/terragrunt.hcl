terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v2.16.0"
    }

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
      private_subnets = ["subnet-10.0.1.0", "subnet-10.0.2.0"]
    }
}

dependency "ssh" {
    config_path = "../security/ssh-security-group"
    mock_outputs = {
      this_security_group_id = "security-group-mock"
    }
}

locals {
common_vars = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
name = "cluster-${local.common_vars.env}"
}

inputs = {
    name                   = local.name
  instance_count         = local.common_vars.instance_number

  ami                    = "ami-ebd02392"
  instance_type          = local.common_vars.instance_type
  vpc_security_group_ids = [dependency.ssh.outputs.this_security_group_id]
  subnet_ids = dependency.vpc.outputs.private_subnets

  tags = {
    Terraform   = "true"
    Environment = local.common_vars.env
}
}