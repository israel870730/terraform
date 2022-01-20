instance_count = "1"
ami_id         = "ami-00f0daacf2cfab09e"
instance_type  = "t2.micro"
key_name       = "key_catalogo"
tags           = { Name = "ec2_catalogo", Enviroment = "Dev" }
name           = "group_catalogo"
description = "SG create from Terraform"
tags_sg = {
    Enviroment = "Test",
    Name = "Prueba"
  }

ingress_rules = [
  {
    description    = "Allow SSH from all"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description    = "Allow HTTP from all"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description    = "Allow ICMP from all"
    from_port   = "8"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description    = "Allow 3306 from all"
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description    = "Allow 8080 from all"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

]
egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description    = "Out Full to internet"
  }
]
public_key = "~/.ssh/id_rsa.pub"

bucket  = "bucket-prueba-israel870730"
acl     = "private"
tags_s3 = { Enviroment = "Test", CreateBy = "catalogo" }
