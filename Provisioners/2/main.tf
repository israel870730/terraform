/*
https://jhooq.com/terraform-provisioner/#1-file-provisioner
https://www.youtube.com/watch?v=DeNflzdjxVM
https://www.youtube.com/watch?v=QxgJlJgGA0E
*/
provider "aws" {
  region = "us-east-1"
}

locals {
  vpc_id           = "vpc-376d984a"     #Cambiar por el ID de la VPC
  subnet_id        = "subnet-7cee7c72"  #Cambiar por el ID de la Subnet
  ssh_user         = "ubuntu"           #Cambiar por el usuario de la instancia
  key_name         = "terraform"        #Cambiar por el nombre de la Key Pair
  private_key_path = "~/terraform.pem"  #Cambiar por la ruta de la Key Pair
  region           = "us-east-1"        #Cambiar por la region
}

resource "aws_security_group" "sg" {
  name        = "sg_terraform"
  vpc_id = local.vpc_id
  description = "Allow SSH and HTTP traffic"

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

  tags = {
    "Name"     = "Terraform"
    "tag_test" = "Prueba"
  }

}

resource "aws_instance" "nginx" {
  ami                         = "ami-0dba2cb6798deb6d8" //us-east-1
  subnet_id                   = local.subnet_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.sg.id]
  key_name                    = local.key_name
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
  EOF

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.public_ip
    }

    inline = [
        "touch /home/ubuntu/test.txt",
        "echo 'Hello World' > /home/ubuntu/test.txt",
        "echo 'Wait until SSH is ready'"
        ]
  }

  provisioner "file" {
     connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.public_ip
    }

    source = "/data/Provisioners/2/index.html"
    //destination = "/var/www/html/index.html"
    destination = "/home/ubuntu/index.html"
  }

  provisioner "local-exec" {
    command = "touch /home/index.html"
  }

  tags = {
    "Name"     = "Provisioner"
    "tag_test" = "Prueba"
  }

}

output "provisioner_local-exec" {
  //value = aws_instance.ubuntu.public_ip
  value = aws_instance.nginx.public_ip
}
