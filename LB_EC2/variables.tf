variable "puerto_servidor" {
  description = "Puerto para las instancias"
  type        = number
  default     = 80

  #Forma de validar una variable
  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65535
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65535."
  }
}

variable "puerto_lb" {
  description = "Puerto para el LB"
  type        = number
  default     = 80
}

variable "puerto_ssh" {
  description = "Puerto SSh para acceder a la instancias"
  type        = number
  default     = 22
}

variable "tipo_instancia" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.nano"
}

variable "public_key" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}

#Variables en forma de mapas
variable "ubuntu_ami" {
    description = "AMI por region"
    type        = map(string)

    default = {
      us-east-1 = "ami-052efd3df9dad4825"
      us-east-2 = "ami-02f3416038bdb17fb"
    }
}

variable "cantidad_instancias" {
  description = "Cantidad de instancias EC2"
  type        = number
  default     = 3
}