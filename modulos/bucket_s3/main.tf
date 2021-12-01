provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "catalogo-auto" {
  bucket = var.bucket
  acl = var.acl
  tags = var.tags
}
