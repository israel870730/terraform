variable "availability_zone" {
  description = "Availbility Zone Database should be deployed to"
  type        = string
  default     = ""
}

variable "name" {
  description = "RDS instance identifier prefix"
  type        = string
  default     = "root-example"
}
