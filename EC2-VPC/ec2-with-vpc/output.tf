output "ip_publica_servidor_1" {
  description = "IP pública IPV4 del servidor"
  value       = "${aws_instance.web.public_ip}"
}