provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "ec2_auto" {
  ami           = "ami-020a4901640485de3"
  instance_type = "t2.micro"
  key_name      = "key-catalogo"
  tags = {
    Name       = "ec2_catalogo"
    Enviroment = "Dev"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "key-catalogo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdt/wEz9PyJ1huC7mOTffBnFQi6FXBWA+nxYHM5Qv15BFBJtsHEJv/Eo9fWeNV2lchh5I5qx6AZ50TgIdqQ2ztLaD3cpQEItPAurazFkVfAyOiFl1tFcu8hdkkiN819O8l+9jwg+wC+vsB6LK/bHsKVlBSOsfO0sZE1Sq46acusz51bGW5SUY4ydDIx2AalJNjbmNgDU9rkoZY0xBJxJ4ecUg5JYrRnlIwt19uxw3R7u0LuuzqL7vofF5hoAW1Yg9Gu3gup+v0XJbLt7Ay1IdaB/FHMpex6+/J555ePqMfri8YNOqRo5Wk5v9pEyy+R9bc98acPBcIX8mIE74URtyz ubuntu@ubuntu"
}
