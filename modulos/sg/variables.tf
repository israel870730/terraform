variable "name" {
  description = "Name of the security group"
}

variable "ingress_rules" {
  description = "Ingress"
}

variable "egress_rules" {
  description = "Egress"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to the resource"
  default     = {}
}

variable "description" {
  description = "description of SG"
}