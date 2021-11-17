provider "aws" {
  region = "us-east-1"
}
resource "aws_security_group" "group_catalogo" {
  name = var.sg_name
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
  }
    tags = {
    Name = "group_catalogo" 
  }
}
resource "aws_instance" "ec2_auto" {
  count = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = var.tags
  security_groups = [aws_security_group.group_catalogo.name]
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
      host     = self.public_ip
      timeout     = "3m"
    }
    inline = ["echo hello"]
    #inline = ["echo hello","docker run -it -d -p 8080:80 870730/curso-terraform:v1"]
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "key_catalogo"
  public_key = "${file(var.public_key)}"
}
output "instance_ips" {
  value = aws_instance.ec2_auto.*.public_ip
}
