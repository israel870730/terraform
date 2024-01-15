output "alias_arn" {
  description = "The ARN for the key alias"
  value       = aws_kms_alias.this[0].arn
}

output "grant_id" {
  description = "The unique identifier for the grant"
  value       = aws_kms_grant.this[0].grant_id
}

output "grant_token" {
  description = "The grant token for the created grant"
  value       = aws_kms_grant.this[0].grant_token
}

output "key_arn" {
  description = "The ARN of the key"
  value       = aws_kms_key.this[0].arn
}

output "key_id" {
  description = "The globally unique identifier for the key"
  value       = aws_kms_key.this[0].key_id
}
