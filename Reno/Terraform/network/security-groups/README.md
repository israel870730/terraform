# Security Group Module

This module creates an `AWS` [VPC Security Group](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) leveraging
offical terraform module [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) 

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create | Whether to create security group and all rules | bool | `"true"` | no |
| egress\_cidr\_blocks | Egress CIDR blocks used to allow ingress access | list(string) | `"null"` | no |
| egress\_rules | List of pre defined rules for egress e.g. ssh-tcp | list(string) | `[]` | no |
| environment | Environment where resources are deployed | string | `"Dev"` | no |
| ingress\_cidr\_blocks | Ingress CIDR blocks used to allow ingress access | list(string) | `"null"` | no |
| ingress\_rules | List of pre defined rules for ingress e.g. ssh-tcp | list(string) | `[]` | no |
| security\_group\_name | Name of security group | string | `"this_security_group"` | no |
| subnet\_tags | Tags used to find subnets for security group | map(string) | `{ "Name": "Private" }` | no |
| tags | A mapping of tags to assign to security group | map(string) | `{}` | no |
| use\_default\_vpc | Whether to use the default VPC - NOT recommended for production\(used for automated testing\)!! | bool | `"false"` | no |
| use\_name\_prefix | Use name prefix | bool | `"false"` | no |
| vpc\_id | ID of VPC to create security group | string | `""` | no |
| vpc\_tags | Tags used to find a vpc for building resources in | map(string) | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_id | ID of the security group that has been created |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"