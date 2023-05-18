include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git//?ref=v3.11.0"

  extra_arguments "init_args" {
    commands = [
      "init"
    ]
    arguments = [
    ]
  }
}

inputs = {
  name = "Main"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Terragrunt-VPC"
    Owner       = "Terragrunt"
    Contact     = "Terragrunt"
    Project     = "Terragrunt"
    Environment = "Development"
  }
}