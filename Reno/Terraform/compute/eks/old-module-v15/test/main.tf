/*data "aws_subnet_ids" "example" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.example.ids
  id       = each.key
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}*/


data "aws_subnet_ids" "default_private" {
  vpc_id = var.vpc_id
  tags   = var.private_subnet_tags
  //tags = {
  //  Name = "Private"
  //}
}

data "aws_subnet_ids" "default_public" {
  vpc_id = var.vpc_id
  tags   = var.public_subnet_tags
  //tags   = {
  //  Name = "Public"
  //}
}

data "aws_subnet" "private_subnets" {
  for_each = data.aws_subnet_ids.default_private.ids
  //for_each = toset(data.aws_subnet_ids.default_private.ids)
  id       = each.key
}

data "aws_subnet" "public_subnets" {
  //for_each = data.aws_subnet_ids.default_private.ids
  for_each = toset(data.aws_subnet_ids.default_public.ids)
  id       = each.key
}

output "subnet_cidr_blocks-private" {
  value = [for s in data.aws_subnet.private_subnets : s.cidr_block]
}

output "subnet_cidr_blocks-public" {
  value = [for s in data.aws_subnet.public_subnets : s.cidr_block]
}