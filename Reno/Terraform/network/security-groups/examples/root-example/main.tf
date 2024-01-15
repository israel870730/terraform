data "aws_vpc" "default" {
  default = true
}

module "sg" {
  source = "../../"

  ingress_rules       = var.ingress_rules
  egress_rules        = var.egress_rules
  security_group_name = var.name
  use_default_vpc     = true
}

