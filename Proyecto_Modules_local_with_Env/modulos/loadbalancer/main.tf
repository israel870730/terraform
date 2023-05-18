//main del modulo load balancer


#----------------
# Creamos el ALB
#----------------
resource "aws_lb" "alb" {
  load_balancer_type        = "application"
  name                      = "terraform-alb-${var.env}"
  security_groups           = [aws_security_group.alb.id]
  //Para obtener todas las subnet donde hay instancias las cuales seran usadas por el LB, debo usar un ciclo "for"
  subnets                   = var.subnet_ids

  tags = {
    "Name"     = "alb-${var.env}"
    "Env"      = "${var.env}"
  }
}

#----------------------
# Creamos el SG del ALB
#----------------------
resource "aws_security_group" "alb" {
  name = "alb-sg-${var.env}"

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

  tags = {
    "Name"     = "sg-alb-${var.env}"
    "Env"      = "${var.env}"
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
  name = "terraform-alb-target-group-${var.env}"
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

  tags = {
    "Env"      = "${var.env}"
  }
}

#-------------------------------
# Attachment para los servidores
#------------------------------- 
resource "aws_lb_target_group_attachment" "servidor" {
  count = length(var.instancia_ids)

  target_group_arn = aws_lb_target_group.this.arn
  //element, hace un acceso a esta coleccion de forma modular
  target_id        = element(var.instancia_ids, count.index)
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