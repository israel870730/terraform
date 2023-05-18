output "instance_ips" {
  value = module.ec2.instancias_public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}