provider "aws" {
  region = "us-east-1"
}

resource "aws_ami_launch_permission" "example" {
  image_id   = "ami-0bd53080253f21d3b"
  account_id = "217866098974"
}
