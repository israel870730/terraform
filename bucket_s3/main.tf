provider "aws" {
  region="us-west-2"
}
resource "aws_s3_bucket" "catalogo-auto" {
  bucket = var.bucket_name
  acl = var.acl
  tags = var.tags
}
