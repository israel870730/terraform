variable "availability_zones" {
  description = "List of Availability Zones in the Region"
  type        = list(string)
  default     = []
}

variable "create_vpc" {
  description = "Whether to create VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "enable DNS hostnames"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "enable DNS support"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "enable nat gateway"
  default     = false
}

variable "enable_vpn_gateway" {
  description = "enable vpn gateway"
  default     = false
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "Dev"
}

variable "isolated_subnets" {
  description = "isolated from the internet"
  type        = string
  default     = "10.1.31.0/24,10.1.32.0/24,10.1.33.0/24"
}

variable "isolated_subnet_tags" {
  description = "Tags to be attached to isolated subnets"
  type        = map
  default = {
    Name = "Isolated"
  }
}

variable "one_nat_gateway_per_az" {
  description = "ensure only one nat gateway is craeted per az"
  type        = string
  default     = "true"
}

variable "private_subnets" {
  description = "private subnets"
  type        = string
  default     = "10.1.11.0/24,10.1.12.0/24,10.1.13.0/24"
}

variable "private_subnet_tags" {
  description = "Tags to be attached to private subnets"
  type        = map
  default = {
    Name = "Private"
  }
}

variable "public_subnets" {
  description = "public subnets"
  type        = string
  default     = "10.1.21.0/24,10.1.22.0/24,10.1.23.0/24"
}

variable "public_subnet_tags" {
  description = "Tags to be attached to public subnets"
  type        = map
  default = {
    Name = "Public"
  }
}

variable "vpc_tags" {
  description = "Arbritary tags for VPC"
  type        = map
  default     = {}
}


variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "this_vpc"
}

variable "vpc_base_cidr" {
  description = "default cidr block"
  type        = string
  default     = "10.1.0.0/16"
}
