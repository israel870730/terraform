provider "aws" {
  region = "us-east-1"
}
module "crear-ec2" {
  source = "./modulos/instance"
  #source = "https://github.com/israel870730/terraform/tree/module_ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  tags = var.tags
  key_name = var.key_name
  public_key = var.public_key
  sg_name = var.sg_name
  ingress_rules = var.ingress_rules
  instance_count = var.instance_count
  egress_rules = var.egress_rules
}
output "module_instance_ip" {
  value = module.crear-ec2.instance_ips
}
