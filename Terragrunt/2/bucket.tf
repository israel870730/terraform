module "bucket" {
    source = "git@github.com:FJavierEstrada/my-terraform-modules.git//aws/storage/s3-bucket?ref=v1.0"

    bucket = "tutorial-bucket-20221219"
    bucket_objects = ["img", "doc", "www"]
}