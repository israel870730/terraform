provider "aws" {
  //region = ${var.region}
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.22.0"
    }
  }
}

//https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v15.0.0/versions.tf