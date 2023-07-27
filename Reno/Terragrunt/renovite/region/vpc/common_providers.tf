provider "aws" {
  region = var.aws_region

  version = ">= 2.0.0"

  skip_get_ec2_platforms     = true
  skip_metadata_api_check    = true
  skip_region_validation     = true
  skip_requesting_account_id = true
}

terraform {
    backend "s3" {}
}
