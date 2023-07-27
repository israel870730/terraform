locals {
  subject_alternative_name = [format("*.%s", var.domain_name)]
}


data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}



module "this" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_name == "" ? local.subject_alternative_name : [var.subject_alternative_name]
  tags                      = var.tags
  zone_id                   = data.aws_route53_zone.this.zone_id
}
