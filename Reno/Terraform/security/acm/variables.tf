variable "domain_name" {
  description = "Domain name for certificate"
  type        = string
}

variable "tags" {
  description = "Certificate tags"
  type        = map
  default = {
    Owner = "Renovite"
  }
}

variable "subject_alternative_name" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = string
  default     = ""
}


