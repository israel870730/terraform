output "module_instance_ip" {
  value = module.crear-ec2.instance_ips
}
output "module_sg_nombre" {
  value = module.sg.name
}
output "module_sg_id" {
  value = module.sg.id
}