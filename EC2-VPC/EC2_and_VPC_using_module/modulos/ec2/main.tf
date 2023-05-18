//main con la logica para el modulo instancias-ec2

#Definimos la Key Pair que va a usar nuestras instancias EC2
resource "aws_key_pair" "terraform_demo" {
  key_name   = "terraform_demo"
  public_key = "${file(var.public_key)}"
}

#-------------------------------------------
# Define una instancia EC2 con un AMI Ubuntu
#-------------------------------------------
resource "aws_instance" "servidor" {
  for_each      = var.servidores

  ami                    = var.ami_id
  instance_type          = var.tipo_instancia
  key_name               = aws_key_pair.terraform_demo.id
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.mi_sg.id]
  subnet_id              = each.value.az

  tags = {
    "Name"     = each.value.nombre
    Terraform   = "true"
    Environment = "dev"
  }
}

#-------------------------------------------
# Grupo de Seguridad para las instancias
#-------------------------------------------
resource "aws_security_group" "mi_sg" {
  name = var.security_groups_name
  vpc_id = var.vpc_id
  description = "Security group for the EC2 instances"
  
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80 desde el exterior"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 22 desde el exterior"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
  }
  egress {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Salida full internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  /*
 dynamic "ingress"{
    for_each = var.ingress_rules
    content {
        from_port = ingress.value.from_port
        to_port = ingress.value.to_port
        protocol = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress"{
    for_each = var.egress_rules
    content {
        from_port = egress.value.from_port
        to_port = egress.value.to_port
        protocol = egress.value.protocol
        cidr_blocks = egress.value.cidr_blocks
    }
  }*/

    tags = {
    Name = "EC2_and_its_own_VPC" 
  }
}