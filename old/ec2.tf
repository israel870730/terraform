module "ec2_cluster" {
#utilizando modulos de GIT
  source                 = "git::https://github.com/israel870730/terraform-aws-ec2-instance?ref=v2.0.0"
  #source                 = "git::https://github.com/israel870730/terraform-aws-ec2-instance?ref=master"
  #source                 = "terraform-aws-modules/ec2-instance/aws"
  #version                = "~> 2.0"
  name                   = "my-cluster"
  #instance_count = 2
  count = 2
  ami                    = "ami-00f0daacf2cfab09e"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.ssh_security_group.security_group_id]
  subnet_ids = module.vpc.private_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ssh_security_group" {
#utilizando modulos de GIT
  source  = "git::https://github.com/israel870730/terraform-aws-security-group//modules/ssh?ref=master"
  #source  = "git::https://github.com/israel870730/terraform-aws-security-group//modules/ssh?ref=v3.0.0"
  #source  = "terraform-aws-modules/security-group/aws//modules/ssh"

  name = "ssh-server"
    description = "Security group for ssh-server with ssh ports open within VPC"
    vpc_id = module.vpc.vpc_id

    ingress_cidr_blocks = ["10.10.0.0/16"]
}
