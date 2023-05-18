//main con la logica para el modulo instancias-ec2

#Definimos la Key Pair que va a usar nuestras instancias EC2
resource "aws_key_pair" "terraform_demo" {
  key_name   = "terraform_demo-${var.env}"
  public_key = "${file(var.public_key)}"
}

#-------------------------------------------
# Define una instancia EC2 con un AMI Ubuntu
#-------------------------------------------
resource "aws_instance" "servidor" {
  for_each      = var.servidores

  ami                    = var.ami_id
  instance_type          = var.tipo_instancia
  //Para obtener el valor en un mapa de "data source" [each.key]
  subnet_id = each.value.az

  vpc_security_group_ids = [aws_security_group.mi_sg.id]
  key_name               = aws_key_pair.terraform_demo.id
  user_data              = <<-EOF
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
  echo "<h1>Deployed via Terraform - Servidor ${each.value.nombre} ${var.env}</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    "Name"     = "${each.value.nombre}_${var.env}"
    "Env"      = "${var.env}"
  }
}

#Grupo de Seguridad para las instancias
resource "aws_security_group" "mi_sg" {
  name          = "servidores-sg-${var.env}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    #Aqui solo permito que accedan a las intancias desde el ALB
    //security_groups = [aws_security_group.alb.id]
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

    tags = {
    "Name"     = "sg-ec2-${var.env}"
    "Env"      = "${var.env}"
  }
}