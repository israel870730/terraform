 variable "main_vpc_cidr" {
    description = "CIDR VPC"
    type = string
    default = "10.0.0.0/16"
 }
 
 variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.5.0/24","10.0.6.0/24"]
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