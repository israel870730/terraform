#-------------------------------------------
# Variables para ambos modulos
#-------------------------------------------
variable "region" {
  description = "Name of the region where the VPC will be created"
  type        = string
  default     = "us-east-1"
}

#-------------------------------------------
# Variables para el modulo VPC
#-------------------------------------------
variable "name_vpc" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "My-VPC"
}

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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {
    //Name = "VPC"
    
  }
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {
    Name = "IGW"
  }
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {
    Type = "public"
  }
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {
    Type = "private"
  }
}

#-------------------------------------------
# Variables para el modulo de EC2
#-------------------------------------------

#Variables en forma de mapas
variable "ubuntu_ami" {
    description = "AMI por region"
    type        = map(string)

    default = {
      us-east-1 = "ami-052efd3df9dad4825"
      us-east-2 = "ami-02f3416038bdb17fb"
    }
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type = string
  default = "t2.nano"
}

variable "vpc_id" {
  description = "ID de la VPC"
  type = string
  default = ""
}

variable security_groups_name {
  description = "Security groups"
  type = string
  default = "SG"
}

#Variable con los servidores que se van a crear
variable "servidores" {
  description = "Mapa de servidores con su correspondiente Az"

  type = map(object({
    nombre = string,
    az     = string,
  }))

 default = {
    "serv-1" = { az = "a", nombre = "servidor-1" }
    "serv-2" = { az = "b", nombre = "servidor-2" }
  }
}



/*variable "ingress_rules" {
  description = "Reglas de entrada del SG"
  type = map(object({
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)
    //cidr_blocks = string   
  }))
   default = [{
    from = 22
    to = 22
    protocol = "ssh"
    cidr = ["0.0.0.0/0"]
  },
  {
    from = 80
    to = 80
    protocol = "tcp"
    cidr = ["0.0.0.0/0"]
  }]
}*/

/*variable "egress_rules" {
  description = "Reglas de salida del SG"
  type = map(object({
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)
  }))
  default = [{
    from = 0
    to = 0
    protocol = "-1"
    cidr = ["0.0.0.0/0"]
  }]
}*/




/*
ingress_rules = [
      {
        from_port = "22",
        to_port = "22",
        protocol = "tcp",
        cidr_blocks = ["0.0.0.0/0"],
      },
      {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port = "8"
        to_port = "-1"
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port = "3306"
        to_port = "3306"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port = "8080"
        to_port = "8080"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
*/