 variable "main_vpc_cidr" {
    description = "CIDR VPC"
    type = string
    default = "10.0.0.0/16"
 }
 
 #Variable con los bloques de ip de las subnet y las Az donde quiero que se creen
 variable "public_subnets" {
  description = "Subnet Public 1"
  type = map(object({
    cidr_subnet_public = string,
    az                 = string,
  }))

  default = {
    "public-1" = { az = "a", cidr_subnet_public = "10.0.1.0/24" }    
    "public-2" = { az = "b", cidr_subnet_public = "10.0.2.0/24" }
}
}

variable "private_subnets" {
  description = "Subnet Private 1"
  type = map(object({
    cidr_subnet_private = string,
    az                  = string,
  }))

  default = {
    "private-1" = { az = "c", cidr_subnet_private = "10.0.3.0/24" }    
    "private-2" = { az = "d", cidr_subnet_private = "10.0.4.0/24" }
}
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