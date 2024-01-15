resource "aws_iam_role" "poc_role" {
  name = "poc_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = "${aws_iam_role.poc_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "attach_amazon_ssm_full_access-poc_role" {
  name       = "attach-amazon-ssm-full-access-poc_role"
  roles      = [aws_iam_role.poc_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_policy_attachment" "attach_amazon_ec2_role_for_ssm-poc_role" {
  name       = "attach-amazon-ec2-role-for-ssm-poc_role"
  roles      = [aws_iam_role.poc_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}


resource "aws_iam_instance_profile" "poc_profile" {
  name = "poc_profile"
  role = "${aws_iam_role.poc_role.name}"
}

# Crear un instancia EC2 para probar el rol creado 
# resource "aws_instance" "role-test" {
#   ami = "ami-05af0694d2e8e6df3"
#   instance_type = "t2.micro"
#   iam_instance_profile = "${aws_iam_instance_profile.poc_profile.name}"
#   key_name = "demo-efs"
#   subnet_id = module.vpc.public_subnets[0]
#   associate_public_ip_address= true
#   vpc_security_group_ids = [aws_security_group.ec2.id]
#   tags= {
#         Name = "poc-role"
#     }
# }

#########################################################################
# Crear un role y adjuntarle dos policys existentes
#########################################################################

# resource "aws_iam_role" "my_role" {
#   name               = "my-iam-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       },
#       Action    = "sts:AssumeRole"
#     }]
#   })
# }

# resource "aws_iam_policy_attachment" "attach_amazon_ssm_full_access" {
#   name       = "attach-amazon-ssm-full-access"
#   roles      = [aws_iam_role.my_role.name]
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
# }

# resource "aws_iam_policy_attachment" "attach_amazon_ec2_role_for_ssm" {
#   name       = "attach-amazon-ec2-role-for-ssm"
#   roles      = [aws_iam_role.my_role.name]
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
# }
