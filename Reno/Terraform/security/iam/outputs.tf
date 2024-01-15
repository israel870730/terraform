output "policy_arn" {
  description = "ARN of created policy"
  value       = module.this_policy.arn
}

output "policy_id" {
  description = "ARN of created policy"
  value       = module.this_policy.id
}

output "role_arn" {
  description = "ARN of created role"
  value       = module.this_assumable_role.this_iam_role_arn
}

output "role_name" {
  description = "Name of created role"
  value       = module.this_assumable_role.this_iam_role_name
}

output "user_arn" {
  description = "ARN of created user"
  value       = module.this_user.this_iam_user_arn
}
