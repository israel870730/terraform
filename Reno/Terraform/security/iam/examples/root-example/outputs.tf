output "policy_arn" {
  description = "ARN of created policy"
  value       = module.iam.policy_arn
}

output "role_arn" {
  description = "ARN of created role"
  value       = module.iam.role_arn
}

output "user_arn" {
  description = "ARN of created user"
  value       = module.iam.user_arn
}