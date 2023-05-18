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
}

#------------------------------------------------
# Data Source para obtener el id del AZ us-east-1
#------------------------------------------------
data "aws_subnet" "public_subnet" {
  for_each = var.servidores

  availability_zone = "${var.region}${each.value.az}"
  default_for_az    = true
}

module "vpc" {
  // https://github.com/terraform-aws-modules/terraform-aws-vpc
  source = "../../modulos/vpc"

  main_vpc_cidr   = var.main_vpc_cidr
  name_vpc        = var.name_vpc
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  region          = var.region

  tags = var.tags
  public_subnet_tags = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags
  igw_tags = var.igw_tags
  vpc_tags = var.vpc_tags
}

module "ec2" {
    source = "../../modulos/ec2"

    ami_id         = local.ami
    tipo_instancia = var.tipo_instancia
    #Aqui le paso el id de la subnet
    servidores      =  {
        for id_ser, datos in var.servidores :
        id_ser => { nombre = datos.nombre, az = data.aws_subnet.public_subnet[id_ser].id }
    }

    #VPC donde se va a crear el SG
    vpc_id         = module.vpc.vpc_id
    security_groups_name  = var.security_groups_name
    //ingress_rules = var.ingress_rules
    //egress_rules  = var.egress_rules

    
} 

