resource "aws_instance" "web" {
  ami           = "ami-0149b2da6ceec4bb0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TerraformEC2_security_group.id]
  key_name = "key_amazon"

tags = {
    Name = "HelloWorld"
}
}

resource "aws_vpc" "terraform" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform"
  }
}