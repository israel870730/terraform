resource "aws_instance" "testinstance" {
    count = 2
    ami = "ami-05af0694d2e8e6df3"
    instance_type = "t2.micro"
    subnet_id = module.vpc.public_subnets[0]
    associate_public_ip_address= true
    vpc_security_group_ids = [aws_security_group.ec2.id]
    key_name="demo-efs"
    tags= {
        Name = "demo-efs"
    }
}