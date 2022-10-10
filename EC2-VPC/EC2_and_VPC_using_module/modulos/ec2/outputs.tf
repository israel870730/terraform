// Nota: Salida de los modulo 
output "instancias_id" {
    description = "Valores de todas los ids de las instancias"
    value       = [ for servidor in aws_instance.servidor : servidor.id ]
}

output "instancias_public_ip" {
    description = "IP publica de todas las instancias"
    value       = [ for servidor in aws_instance.servidor : servidor.public_ip ]
}

/*output "instancias_dns_publica" {
  description = "DNS pública del servidor"
  value       = "http://${aws_instance.servidor.public_dns}"
}*/