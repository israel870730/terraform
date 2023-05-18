//variables para el modulo instancias-ec2
// Nota: estos son los imput con los que trabajara el modulo 
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

variable "tipo_instancia" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "ami_id" {
    description = "AMI por region"
    type        = string
}

variable "servidores" {
  description = "Mapa de servidores con nombres subnet_id"

  type = map(object({
    nombre = string,
    az     = string,
  })
  )
}

variable "public_key" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "puerto_ssh" {
  description = "Puerto ssh para las instancias"
  type        = number
  default     = 22
}

variable "env" {
  description = "Entorno en el que estamos trabajando"
  type        = string 
  default     = ""
}