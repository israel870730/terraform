output "dns_ALB" {
    description = "DNS pública del load balancer"
    value = "http://${aws_lb.alb.dns_name}:${var.puerto_lb}"
}

output "dns_publica_servidor" {
  description = "DNS pública del servidor"
  value       = [ for servidor in aws_instance.servidor : 
  "http://${servidor.public_dns}:${var.puerto_servidor}"
  ]
}

output "ip_publica_servidor" {
  description = "IP pública IPV4 del servidor"
  value       = [ for servidor in  aws_instance.servidor : "${servidor.public_ip}"]
}