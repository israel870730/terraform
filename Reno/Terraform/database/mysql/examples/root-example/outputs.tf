output "db_instance_id" {
  description = "DNS name of the RDS instance created"
  value       = module.db.db_instance_id
}