// Nota: Salida de los modulo 
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.Main.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.Main.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.Main.cidr_block
}