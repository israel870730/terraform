# 1- Create the VPC
# 2- Create Internet Gateway and attach it to VPC
# 3- Create a Public Subnets
# 4- Creating Private Subnets
# 5- Route table for Public Subnet's
# 6- Route table for Private Subnet's
# 7- Route table Association with Public Subnet's
# 8- Route table Association with Private Subnet's
# 9- Creating the NAT Gateway using subnet_id and allocation_id

#------------------------------------------------------
# Ejemplo hecho para usar el bucle "for_each"
#------------------------------------------------------

provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
}

#----------------
# Create the VPC
#----------------
 resource "aws_vpc" "Main" {                # Creating VPC here
   cidr_block       = var.main_vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
   instance_tenancy = "default"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
   tags = {
    "Name" = "VPC Main"
    "From" = "Terraform"
   }
 }

 #---------------------------------------------
 # Create Internet Gateway and attach it to VPC
 #---------------------------------------------
 resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
    tags = {
      "Name" = "IGW VPC Main"
      "From" = "Terraform"
    }
 }

 #-------------------------
 # Create a Public Subnets
 #-------------------------
 resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
   vpc_id                  = aws_vpc.Main.id
   for_each                = var.public_subnets

   cidr_block              = each.value.cidr_subnet_public        # CIDR block of public subnets
   #availability_zone       = each.value.az
   availability_zone       = "${local.region}${each.value.az}"


   map_public_ip_on_launch = "true" //it makes this a public subnet
   tags = {
    "Name" = var.public_subnet_suffix
    "CIDR" = each.value.cidr_subnet_public
    "From" = "Terraform"
  }
 }

 #--------------------------
 # Creating Private Subnets
 #--------------------------
 resource "aws_subnet" "privatesubnets" {
   vpc_id            =  aws_vpc.Main.id
   for_each          = var.private_subnets

   cidr_block        = each.value.cidr_subnet_private
   #availability_zone = each.value.az
   availability_zone       = "${local.region}${each.value.az}"

   tags = {
    "Name" = var.private_subnet_suffix
    "CIDR" = each.value.cidr_subnet_private
    "From" = "Terraform"
  }
 }

 #---------------------------------
 # Route table for Public Subnet's
 #---------------------------------
 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.Main.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
     }
    tags = {
        "Name" = "RT subnet public"
        "From" = "Terraform"
    }
 }

 #----------------------------------
 # Route table for Private Subnet's
 #----------------------------------
 resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.Main.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
   tags = {
        "Name" = "RT subnet private"
        "From" = "Terraform"
    }
 }

 #---------------------------------------------
 # Route table Association with Public Subnet's
 #---------------------------------------------
 resource "aws_route_table_association" "PublicRTassociation" {
    //count = length(var.public_subnets)
    //subnet_id = aws_subnet.publicsubnets[count.index].id

    for_each                = var.public_subnets
    subnet_id = aws_subnet.publicsubnets[each.key].id
    route_table_id = aws_route_table.PublicRT.id
 }

 #----------------------------------------------
 # Route table Association with Private Subnet's
 #----------------------------------------------
 resource "aws_route_table_association" "PrivateRTassociation" {
    //count = length(var.public_subnets)
    //subnet_id = aws_subnet.privatesubnets[count.index].id

    for_each                = var.private_subnets
    subnet_id = aws_subnet.privatesubnets[each.key].id
    route_table_id = aws_route_table.PrivateRT.id
 }

#--------------------------
# IP fot the NAT VPC MAIN
#--------------------------
 resource "aws_eip" "nateIP" {
   vpc   = true
   tags = {
        "Name" = "IP for NAT VPC Main"
        "From" = "Terraform"
    }
 }

 #-----------------------------------------------------------
 # Creating the NAT Gateway using subnet_id and allocation_id
 #-----------------------------------------------------------
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   
   //subnet_id = {for k, v in aws_subnet.publicsubnets : k => v.id}

   //subnet_id = aws_subnet.publicsubnets.[each.value].id
   subnet_id = aws_subnet.publicsubnets["public-1"].id
   tags = {
        "Name" = "NAT Gateway for subnet private on VPC Main"
        "From" = "Terraform"
    }
 }