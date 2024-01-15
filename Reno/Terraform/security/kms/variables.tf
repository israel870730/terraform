variable "alias_name" {
  description = "Name of key alias"
  type        = string
  default     = "renovite-key"
}

variable "alias_target_key_id" {
  description = " Identifier for the key for which the alias is for, ARN or key_id accepted"
  type        = string
  default     = ""
}
variable "create_alias" {
  description = "Whether to create key alias"
  type        = bool
  default     = true
}

variable "create_grant" {
  description = "Whether to create grant"
  type        = bool
  default     = false
}

variable "create_key" {
  description = "Whether to create key"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environmen to create resources in"
  type        = string
  default     = "Dev"
}

variable "grant_operations" {
  description = "A list of operations that the grant permits"
  type        = list(string)
  default     = ["Encrypt", "Decrypt", "DescribeKey", "GenerateDataKey"]
}

variable "grant_principal" {
  description = "The principal that is given permission to perform the operations that the grant permits in ARN format"
  type        = string
  default     = ""
}

variable "key_deletion_window" {
  description = "Duration in days after which the key is deleted"
  type        = number
  default     = 7
}

variable "key_description" {
  description = "The description for the key"
  type        = string
  default     = "Renovite KMS Key"
}

variable "key_enabled" {
  description = "Whether key is enabled"
  type        = bool
  default     = true
}

variable "key_enable_rotation" {
  description = "Whether to enable key rotation"
  type        = bool
  default     = false
}

variable "key_usage" {
  description = "Specifies the intended use of the key, only symmetric encryption and decryption are supported"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "policy" {
  description = "A valid policy JSON document to associate with KMS resources"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the KMS resources"
  type        = map
  default     = {}
}
