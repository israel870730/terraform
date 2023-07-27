module "db" {
  source = "../../"

  values = {
    availability_zone = var.availability_zone == "" ? null : var.availability_zone
    identifier        = var.name
    instance_class    = "db.t3.micro"
  }
  use_default_vpc = true
}
