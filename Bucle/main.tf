###########################
#  Definir el provider   ##
###########################
provider "aws" {
  region = "us-east-1"
}

#Ejemplo usando "count"
#Usando "count" lo que devuelve es una lista
resource "aws_iam_user" "ejemplo" {
#Cuando uso el "count" con la variable type = set(string)
  //count = length(var.usuarios)
  //name  = "usuario-${var.usuarios[count.index]}"

#Cuando uso "count" con la variable type = number
  count = var.usuarios
  name  = "usuario-ejemplo.${count.index}"  
}

#ejemplo usando for_each
#for_each solo trabaja con el tipo de variables "set" o "map"
/*resource "aws_iam_user" "ejemplo" {
  for_each = var.usuarios

  name  = "usuario-${each.value}"
}*/