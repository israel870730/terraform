module "efs" {
  source = "../../"

  efs_name        = var.efs_name
  use_default_vpc = true
}