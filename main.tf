terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-east-1"
}
module "sg" {
  source        = "./modulos/sg"
  name          = var.name
  description = var.description
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  tags = var.tags_sg
}
module "crear-ec2" {
  source = "./modulos/instance"
  #source = "https://github.com/israel870730/terraform/tree/module_ec2"
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  tags                   = var.tags
  key_name               = var.key_name
  public_key             = var.public_key
  instance_count         = var.instance_count
  vpc_security_group_ids = [module.sg.id]
}

module "crear-s3" {
  source = "./modulos/bucket"
  bucket = var.bucket
  acl    = var.acl
  tags   = var.tags_s3
}
