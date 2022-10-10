resource "aws_instance" "web" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type

# Public Subnet assign to instance
  subnet_id     = aws_subnet.public_1.id

# Security group assign to instance
  vpc_security_group_ids=[aws_security_group.allow_ssh.id]

# key name
key_name = var.key_name
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
    Name = "Ec2-with-VPC"
  }
}