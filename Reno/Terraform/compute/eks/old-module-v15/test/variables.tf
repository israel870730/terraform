variable "vpc_id" {
  description = "ID for the VPC to deploy EKS cluster"
  type        = string
  default     = "vpc-01b3f79ec3258feea"
}

variable "public_subnet_tags" {
  description = "Subnet Tags to find database subnets"
  type        = map
  default = {
    Name = "Public"
  }
}

variable "private_subnet_tags" {
  description = "Subnet Tags to find database subnets"
  type        = map
  default = {
    Name = "Private"
  }
}
