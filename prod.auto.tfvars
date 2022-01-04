instance_count = "1"
ami_id         = "ami-00f0daacf2cfab09e"
instance_type  = "t2.large"
key_name       = "key_catalogo"
tags           = { Name = "ec2_catalogo_prod", Enviroment = "Prod" }
sg_name        = "group_catalogo"
ingress_rules = [
  {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = "8"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
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
  }
]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdt/wEz9PyJ1huC7mOTffBnFQi6FXBWA+nxYHM5Qv15BFBJtsHEJv/Eo9fWeNV2lchh5I5qx6AZ50TgIdqQ2ztLaD3cpQEItPAurazFkVfAyOiFl1tFcu8hdkkiN819O8l+9jwg+wC+vsB6LK/bHsKVlBSOsfO0sZE1Sq46acusz51bGW5SUY4ydDIx2AalJNjbmNgDU9rkoZY0xBJxJ4ecUg5JYrRnlIwt19uxw3R7u0LuuzqL7vofF5hoAW1Yg9Gu3gup+v0XJbLt7Ay1IdaB/FHMpex6+/J555ePqMfri8YNOqRo5Wk5v9pEyy+R9bc98acPBcIX8mIE74URtyz ubuntu@ubuntu"
