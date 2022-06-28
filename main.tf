provider "aws" {
  region = "us-east-1"
}

variable "public_key" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}

resource "aws_key_pair" "terraform_demo" {
  key_name   = "terraform_demo"
  public_key = "${file(var.public_key)}"
}

#Como obtener los datos de un "Data source"
/* Data sources allow Terraform to use information defined outside of Terraform, 
defined by another separate Terraform configuration, or modified by functions. */

/*En este caso vamos a obtener informacion de las subredes en AWS que no fueron 
creadas por terraform pero que usando "data source" podermos acceder a ella*/
data "aws_subnet" "az_a" {
  availability_zone = "us-east-1a"
  default_for_az    = true
}

data "aws_subnet" "az_b" {
  availability_zone = "us-east-1b"
  default_for_az    = true
}

resource "aws_instance" "mi_servidor_1" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"

  #Para acceder al valor del data source creado anteriormente
  # data."tipo"."nombre"."argumento"
  subnet_id = data.aws_subnet.az_a.id

  #Las referencias a los atributos de otros recursos son de la forma:
  #tipo_del_recurso.nombre_del_recurso.atributo
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
  echo "<h1>Deployed via Terraform - Servidor 1</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    "Name" = "Primer-Server-1"
  }
}

resource "aws_instance" "mi_servidor_2" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.az_b.id
  #Las referencias a los atributos de otros recursos son de la forma:
  #tipo_del_recurso.nombre_del_recurso.atributo
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
  echo "<h1>Deployed via Terraform - Servidor 2</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    "Name" = "Segundo-Server-2"
  }
}

resource "aws_security_group" "mi_sg" {
  name          = "primer-servidor-sg"

  ingress {
    //cidr_blocks = ["0.0.0.0/0"]
    #Aqui solo permito que accedan a las intancias desde el ALB
    security_groups = [aws_security_group.alb.id]
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
}

#Creamos el ALB
resource "aws_lb" "alb" {
  load_balancer_type        = "application"
  name                      = "terraform-alb"
  security_groups           = [aws_security_group.alb.id]
  subnets                   = [data.aws_subnet.az_a.id, data.aws_subnet.az_b.id] 
}

#Creamos el SG del ALB
resource "aws_security_group" "alb" {
  name = "alb-sg"

   ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso al puerto 80 desde el exterior"
    from_port   = 80
    to_port     = 80
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

#Creamos el Targuet Group
resource "aws_lb_target_group" "this" {
  name = "terraform-alb-target-group"
  port = 80
  vpc_id = data.aws_vpc.default.id
  protocol = "HTTP"
  
  health_check {
    enabled   = true
    matcher  = "200"
    path     = "/" 
    port     = "80"
    protocol = "HTTP"
  }
}

#Adjuntamos el servidor #1 al targuet group que pertenece al ALB
resource "aws_lb_target_group_attachment" "servidor_1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.mi_servidor_1.id
  port             = 80
}

#Adjuntamos el servidor #2 al targuet group que pertenece al ALB
resource "aws_lb_target_group_attachment" "servidor_2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.mi_servidor_2.id
  port             = 80
}

#Creamos el listener para el TG
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  } 
}