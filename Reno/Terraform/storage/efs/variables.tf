variable "use_default_vpc" {
  description = "Whether the default vpc is used?"
  type        = bool
  default     = false
}

variable "tags" {
  description = "generic tags"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "vpc tags"
  type        = map(string)
  default     = {}
}

variable "efs_name" {
  description = "efs name"
  type        = string
  default     = "efs-default"
}

variable "create_security_group" {
  description = "Whether a security group should be created"
  type        = bool
  default     = true
}

variable "efs_security_group_ids" {
  description = "security group ids for efs"
  type        = list(string)
  default     = []
}

variable "efs_encrypted" {
  description = "Whether encryption should be used"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environmen to create resources in"
  type        = string
  default     = "Dev"
}

variable "subnet_tags" {
  description = "Tags to be attached to subnets"
  type        = map
  default = {
    Name = "Private"
  }
}