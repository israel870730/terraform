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
<<<<<<< HEAD
  #key_name   = var.key_name_public
  #public_key = var.public_key
  key_name   = "key_catalogo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD1Go6CLw1cYSzwhb9QU4q/uDF4RVdTBkkDaq3vEM2maFemRbHI3tG9guGRNRXCnvRAbz+09aJGPTZ4lTEaqBY1YiAV7lt3g+sRBO3g412Lu6JBsvEKyjgzYai1CZUSSgEmUHTh5DYT/K5S/POog9X1EZ9+iL+1/yHgZmBMCXP8KuJqwUHG5AoKKt8RydH4OnJvQDN0dhCeiVXYNISer1LjVFZTObwtzL5nOSe+GE+T0I6tKYD7mk0IDUGPk8A4pcJGQnVlSYVX1FgXuOoaHrGVvIGWxuJz4+xIdfU4iGr1OcosXa77WdRPItp/8lFPgLvL+wZomT4SzSsUN+8a2rIpmqafI2bCj6fC1dx53tmGpEgCKjBI/oFCzQzDMNpqCwMWOTXFAZ+IamNDhF2rRrRHKEUta3UABczu6g72SAgKlsq5hNdGXLAy8Mer+vFb2m4XizCXG+mrUuipWgJrcnKjraaC4viy2L3XZnL7L6YlD8yFjLkIcBPLQ1RWDO0l3Cc= israel@vm"
=======
  key_name   = var.key_name_public
  public_key = var.public_key
>>>>>>> 81c0bdaaa0af23bef52070c7eb36e9fae9ae618e
}
output "instance_ips" {
  value = aws_instance.ec2_auto.*.public_ip
}
