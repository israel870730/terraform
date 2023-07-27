output "key_arn" {
  description = "The ARN of the key"
  value       = module.kms.key_arn
}

output "key_id" {
  description = "The globally unique identifier for the key"
  value       = module.kms.key_id
}