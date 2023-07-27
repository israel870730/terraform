variable "egress_rules" {
  description = "List of rules for  egress access"
  type        = list(string)
  default     = ["http-80-tcp", "https-443-tcp", "ssh-tcp", "mysql-tcp"]
}

variable "ingress_rules" {
  description = "List of rules for ingress access"
  type        = list(string)
  default     = ["http-80-tcp", "https-443-tcp", "ssh-tcp", "mysql-tcp"]
}

variable "name" {
  description = "Name of security group"
  type        = string
  default     = "root-example-sg"
}