output "id" {
  description = "ID of the security group."
  value       = aws_security_group.sg.id
}

output "name" {
  value = aws_security_group.sg.name
}
