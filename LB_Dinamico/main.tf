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

#Definimos la Key Pair que va a usar nuestras instancias EC2
resource "aws_key_pair" "terraform_demo" {
  key_name   = "terraform_demo"
  public_key = "${file(var.public_key)}"
}

#Como obtener los datos de un "Data source"
/* Data sources allow Terraform to use information defined outside of Terraform, 
defined by another separate Terraform configuration, or modified by functions. */

/*En este caso vamos a obtener informacion de las subredes en AWS que no fueron 
creadas por terraform pero que usando "data source" podermos acceder a ella*/
#------------------------------------------------
# Data Source para obtener el id del AZ us-east-1
#------------------------------------------------
data "aws_subnet" "public_subnet" {
  for_each = var.servidores

  availability_zone = "${local.region}${each.value.az}"
  default_for_az    = true
}

#-------------------------------------------
# Define una instancia EC2 con un AMI Ubuntu
#-------------------------------------------
resource "aws_instance" "servidor" {
  for_each      = var.servidores
  
  ami           = local.ami
  instance_type = var.tipo_instancia
  //Para obtener el valor en un mapa de "data source" [each.key]
  subnet_id = data.aws_subnet.public_subnet[each.key].id //each.key es ser-1 o ser-2
  vpc_security_group_ids = [aws_security_group.mi_sg.id]
  key_name = aws_key_pair.terraform_demo.id
  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  echo "*** Staring apache2"
  sudo systemctl start apache2
  echo "*** Enable apache2"
  sudo systemctl enable apache2
  echo "*** Edit file index.html"
  echo "<h1>Deployed via Terraform - Servidor ${each.value.nombre}</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    "Name" = each.value.nombre
    "tag_test" = "Prueba"
  }
}

#Grupo de Seguridad para las instancias
resource "aws_security_group" "mi_sg" {
  name          = "primer-servidor-sg"

  ingress {
    //cidr_blocks = ["0.0.0.0/0"]
    #Aqui solo permito que accedan a las intancias desde el ALB
    security_groups = [aws_security_group.alb.id]
    description = "Acceso al puerto 80 desde el exterior"
    from_port   = var.puerto_servidor
    to_port     = var.puerto_servidor
    protocol    = "TCP"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 22 desde el exterior"
    from_port   = var.puerto_ssh
    to_port     = var.puerto_ssh
    protocol    = "TCP"
  }
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Salida full internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }
}

#----------------
# Creamos el ALB
#----------------
resource "aws_lb" "alb" {
  load_balancer_type        = "application"
  name                      = "terraform-alb"
  security_groups           = [aws_security_group.alb.id]
  //Para obtener todas las subnet donde hay instancias las cuales seran usadas por el LB, debo usar un ciclo "for"
  subnets                   = [for subnet in data.aws_subnet.public_subnet : subnet.id ] 
}

#----------------------
# Creamos el SG del ALB
#----------------------
resource "aws_security_group" "alb" {
  name = "alb-sg"

   ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80 desde el exterior"
    from_port   = var.puerto_lb
    to_port     = var.puerto_lb
    protocol    = "TCP"
   }
   egress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Salida full internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }
}

#Creamos un data source para acceder al id de la VPC que precisa el TG
data "aws_vpc" "default" {
  default = true
}

#-------------------------
# Creamos el Targuet Group
#-------------------------
resource "aws_lb_target_group" "this" {
  name = "terraform-alb-target-group"
  port = 80
  vpc_id = data.aws_vpc.default.id
  protocol = "HTTP"
  
  health_check {
    enabled   = true
    matcher  = "200"
    path     = "/" 
    port     = var.puerto_servidor
    protocol = "HTTP"
  }
}

#-------------------------------
# Attachment para los servidores
#------------------------------- 
resource "aws_lb_target_group_attachment" "servidor" {
  for_each = var.servidores
  
  target_group_arn = aws_lb_target_group.this.arn
  //Para acceder al id de cada instancias que esta en el mapa de instancias 
  target_id        = aws_instance.servidor[each.key].id
  port             = var.puerto_servidor
}

#------------------------------
#Creamos el listener para el LB
#------------------------------
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.puerto_lb
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  } 
}