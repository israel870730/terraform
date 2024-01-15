# VPC Module

This module creates an `AWS` [VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) leveraging
offical terraform module [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) 

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_zones | List of Availability Zones in the Region | list(string) | `[]` | no |
| create\_vpc | Whether to create VPC | bool | `"true"` | no |
| enable\_dns\_hostnames | enable DNS hostnames | bool | `"false"` | no |
| enable\_dns\_support | enable DNS support | bool | `"true"` | no |
| enable\_nat\_gateway | enable nat gateway | string | `"false"` | no |
| enable\_vpn\_gateway | enable vpn gateway | string | `"false"` | no |
| environment | Environment Name | string | `"Dev"` | no |
| isolated\_subnet\_tags | Tags to be attached to isolated subnets | map | `{ "Name": "Isolated" }` | no |
| isolated\_subnets | isolated from the internet | string | `"10.1.31.0/24,10.1.32.0/24,10.1.33.0/24"` | no |
| one\_nat\_gateway\_per\_az | ensure only one nat gateway is craeted per az | string | `"true"` | no |
| private\_subnet\_tags | Tags to be attached to private subnets | map | `{ "Name": "Private" }` | no |
| private\_subnets | private subnets | string | `"10.1.11.0/24,10.1.12.0/24,10.1.13.0/24"` | no |
| public\_subnet\_tags | Tags to be attached to public subnets | map | `{ "Name": "Public" }` | no |
| public\_subnets | public subnets | string | `"10.1.21.0/24,10.1.22.0/24,10.1.23.0/24"` | no |
| vpc\_base\_cidr | default cidr block | string | `"10.1.0.0/16"` | no |
| vpc\_name | vpc name | string | `"this_vpc"` | no |
| vpc\_tags | Arbritary tags for VPC | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| isolated\_cidr\_blocks | List of IDs of isolated CIDR blocks |
| isolated\_subnets | List of IDs of isolated subnets |
| private\_cidr\_blocks | List of IDs of private CIDR blocks |
| private\_subnets | List of IDs of private subnets |
| public\_cidr\_blocks | List of IDs of public CIDR blocks |
| public\_subnets | List of IDs of public subnets |
| vpc |  |
| vpc\_id | The ID for the created VPC |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"