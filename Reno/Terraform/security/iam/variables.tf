variable "create_role" {
  description = "Whether to create role"
  type        = string
  default     = "false"
}

variable "create_user" {
  description = "Whether to create user"
  type        = string
  default     = "false"
}

variable "create_user_login_profile" {
  description = "Whether to a UI access profile"
  type        = string
  default     = "false"
}


variable "create_access_key" {
  description = "Whether to create IAM access key"
  type        = string
  default     = "true"
}

variable "custom_role_policy_arn" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list
  default     = []
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "Dev"
}


variable "policy" {
  description = "The policy JSON data accepts template(.tpl)"
  type        = string
  default     = ""
}

variable "policy_description" {
  description = "The description of the policy"
  type        = string
  default     = "Renovite IAM Policy"
}

variable "policy_name" {
  description = "Name of the policy"
  type        = string
  default     = "reno-iam-policy"
}

variable "policy_path" {
  description = "The path in IAM"
  type        = string
  default     = "/"
}


variable "role_name" {
  description = "Name of role"
  type        = string
  default     = "reno-iam-role"
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = string
  default     = "false"
}

variable "role_tags" {
  description = "A map of tags to add to all role resources."
  type        = map
  default     = {}
}

variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list
  default     = []
}

variable "user_name" {
  description = "Name for IAM User"
  type        = string
  default     = "reno-iam-user"
}

variable "user_tags" {
  description = "A map of tags to add to all user resources."
  type        = map
  default     = {}
}