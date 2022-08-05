// Nota: Salida de los modulo 
output "instancias_id" {
    description = "Valores de todas los ids de las instancias"
    value       = [for servidor in aws_instance.servidor : servidor.id ]
}