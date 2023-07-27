variable "defaults" {
  description = "Map with MySQL default settings"
  type        = any

  default = {
    allocated_storage           = 10
    allow_major_version_upgrade = false
    auto_minor_version_upgrade  = false
    backup_window               = "01:00-01:30"
    ca_cert_identifier          = "rds-ca-2019"
    deletion_protection         = false
    engine                      = "mysql"
    engine_version              = "8.0.13"
    family                      = "mysql8.0"
    identifier                  = "renodemo"
    instance_class              = "db.t3.large"
    major_engine_version        = "8.0"
    maintenance_window          = "Mon:02:00-Mon:05:00"
    multi_az                    = false
    option_group_name           = "default:mysql-8-0"
    parameter_group_name        = "default.mysql8.0"
    password                    = "changeme"
    port                        = "3306"
    storage_encrypted           = false
    timezone                    = "UTC"
    username                    = "demouser"
  }
}

variable "restore_from_snapshot" {
  description = "Whether to restore from snapshot"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Snapshot ID that DB should be restored from"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "ID that DB should be backed up to"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}
variable "environment" {
  description = "Environment name to deploy resources"
  type        = string
  default     = "Dev"
}

variable "create_security_group" {
  description = "Create Security Group Access for Private subnets on port 3306"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "use_default_vpc" {
  description = "Whether to use the default VPC - NOT recommended for production(used for automated testing)!"
  type        = bool
  default     = false
}

variable "values" {
  description = "Map with MySQL custom settings, see defaults for options"
  type        = any
  default     = {}
}

variable "vpc_tags" {
  description = "Tags used to find a vpc for building resources in"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Subnet Tags of EKS nodes to pass to security group for access"
  type        = map
  default = {
    Name = "Private"
  }
}

variable "subnet_tags" {
  description = "Subnet Tags to find database subnets"
  type        = map
  default = {
    Name = "Isolated"
  }
}