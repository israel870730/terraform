###########################
#  Definir el provider   ##
###########################

provider "aws" {
  region = local.region
}

#--------------------------------
#Definicion de variables locales
#--------------------------------
locals {
  region = "us-east-1"
  ami    = var.ubuntu_ami[local.region]
  env    = "prod"
}

#------------------------------------------------
# Data Source para obtener el id del AZ us-east-1
#------------------------------------------------
data "aws_subnet" "public_subnet" {
  for_each = var.servidores

  availability_zone = "${local.region}${each.value.az}"
  default_for_az    = true
}

module "servidores_ec2" {
    source = "../../modulos/instances-ec2"

    puerto_servidor = 80
    puerto_ssh = 22
    tipo_instancia  = var.tipo_instancia
    ami_id          = local.ami
    servidores      =  {
        for id_ser, datos in var.servidores :
        id_ser => { nombre = datos.nombre, az = data.aws_subnet.public_subnet[id_ser].id }

    }
    env             = local.env
}

module "loadbalancer" {
    source = "../../modulos/loadbalancer"

    subnet_ids      = [for subnet in data.aws_subnet.public_subnet : subnet.id]
    instancia_ids   = module.servidores_ec2.instancias_id
    puerto_servidor = 80
    puerto_lb       = 80
    env             = local.env
}