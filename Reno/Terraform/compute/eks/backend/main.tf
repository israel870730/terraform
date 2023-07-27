###########################
#  We Create Bucket S3    #
###########################
resource "aws_s3_bucket" "terraform_state" {
  bucket     = var.bucket
  tags       = var.tags
  acl        = "private"
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

#############################
#  We create dynamodb table #
#############################
resource "aws_dynamodb_table" "terraform_locks" {
  name = var.name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}