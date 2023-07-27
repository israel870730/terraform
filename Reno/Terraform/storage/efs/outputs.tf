output "arn" {
  description = "The Amazon Resource Name of the file system"
  value       = aws_efs_file_system.this.arn
}

output "id" {
  description = "The ID that identifies the file system"
  value       = aws_efs_file_system.this.id
}

output "dns_name" {
  description = "The DNS name for the filesystem per documented convention"
  value       = aws_efs_file_system.this.dns_name
}