terraform {
  backend "s3" {
    bucket = "safe-state-terraform"
    key    = "dev/state"
    region = "us-east-1"
  }
}
