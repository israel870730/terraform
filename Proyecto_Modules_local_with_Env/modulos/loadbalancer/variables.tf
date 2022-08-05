//variables para el modulo loadbalancer
// Nota: estos son los imput con los que trabajara el modulo 

variable "subnet_ids" {
  description = "Todos los ids de las subnets donde provisionaremos el loadbalancer"
  type        = set(string)
}

variable "instancia_ids" {
  description = "Ids de las instancias EC2"
  type       = list(string)
}

variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
  default     = 80

  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65535
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65535."
  }
}

variable "puerto_lb" {
    description = "Puerto para el Load Balancer"
    type        = number
    default     = 80
}

variable "env" {
  description = "Entorno en el que estamos trabajando"
  type        = string 
  default     = ""
}