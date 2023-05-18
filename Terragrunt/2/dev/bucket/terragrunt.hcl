terraform {
  source = "git@github.com:FJavierEstrada/my-terraform-modules.git//aws/storage/s3-bucket?ref=v1.0"
    }

include {
  path = find_in_parent_folders()
}

locals {
common_vars = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
name = "javier-estrada-tutorial-bucket-${local.common_vars.env}"
}

inputs = {
bucket = local.name
    bucket_objects = ["img", "doc", "www"]
}