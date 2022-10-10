variable "name_vpc" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "region" {
  description = "Name of the region where the resources will be created"
  type        = string
  default     = ""
}

 variable "main_vpc_cidr" {
    description = "CIDR VPC"
    type = string
 }

 #Variable con los bloques de ip de las subnet y las Az donde quiero que se creen
 variable "public_subnets" {
  description = "Subnet Public 1"
  type = map(object({
    cidr_subnet_public = string,
    az                 = string,
  }))
}

variable "private_subnets" {
  description = "Subnet Private 1"
  type = map(object({
    cidr_subnet_private = string,
    az                  = string,
  }))
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "Subnet Public"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "Subnet Private"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}