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

#Variables en forma de mapas
variable "ubuntu_ami" {
    description = "AMI por region"
    type        = map(string)

    default = {
      us-east-1 = "ami-052efd3df9dad4825"
      us-east-2 = "ami-02f3416038bdb17fb"
    }
}

#Variable con los servidores que se van a crear
variable "servidores" {
  description = "Mapa de servidores consu correspondiente Az"

  type = map(object({
    nombre = string,
    az     = string,
  }))

  default = {
    "serv-1" = { az = "a", nombre = "servidor-1" }
    "serv-2" = { az = "b", nombre = "servidor-2" }
  }
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type = string
  default = "t2.small"
}