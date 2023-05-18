variable "public_key" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ami_id" {
  description = "AMI por region"
  type        = string
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type = string
}

variable security_groups_name {
  description = "Security groups"
  type = string
  default = ""
}

#Variable con los servidores que se van a crear
variable "servidores" {
  description = "Mapa de servidores con su correspondiente Az"

  type = map(object({
    nombre = string,
    az     = string,
  }))
}

/*variable "ingress_rules" {
  description = "Reglas de entrada del SG"
  type = map(object({
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)  
  }))
}

variable "egress_rules" {
  description = "Reglas de salida del SG"
  type = map(object({
    from_port   = number,
    to_port     = number,
    protocol    = string,
    cidr_blocks = list(string)
  }))
}*/