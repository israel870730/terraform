instance_count="1"
ami_id="ami-00f0daacf2cfab09e"
instance_type="t2.micro"
key_name="key_catalogo"
tags={Name="ec2_catalogo",Enviroment="Dev"}
sg_name = "group_catalogo"
ingress_rules = [
    {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        from_port = "8"
        to_port = "-1"
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        from_port = "3306"
        to_port = "3306"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        from_port = "8080"
        to_port = "8080"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

]
egress_rules = [
    {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
]
key_name_public="key_catalogo"
public_key = "~/.ssh/id_rsa.pub"
