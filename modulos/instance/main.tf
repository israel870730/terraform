resource "aws_instance" "ec2_auto" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  tags                   = var.tags
  vpc_security_group_ids = var.vpc_security_group_ids
  #vpc_security_group_ids  = var.this_security_group_id
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
      timeout     = "3m"
    }
    inline = ["echo hello"]
    #inline = ["echo hello","docker run -it -d -p 8080:80 870730/curso-terraform:v1"]
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "key_catalogo"
  public_key = file(var.public_key)
}
output "instance_ips" {
  value = aws_instance.ec2_auto.*.public_ip
}


#resource "aws_ebs_volume" "st1" {
# availability_zone = aws_instance.ec2_auto[count.index]["availability_zone"]
# size = 1
# tags= {
#    Name = "My volume"
#  }
#}

#resource "aws_volume_attachment" "ebs" {
# device_name = "/dev/sdh"
# volume_id = aws_ebs_volume.st1.id
# instance_id = aws_instance.ec2_auto.id
#}
