# ACM Module

This module creates an `AWS` [ACM](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html) leveraging
offical terraform module [terraform-aws-acm](https://github.com/terraform-aws-modules/terraform-aws-acm) 

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain\_name | Domain name for certificate | string | n/a | yes |
| subject\_alternative\_name | A list of domains that should be SANs in the issued certificate | string | `""` | no |
| tags | Certificate tags | map | `{ "Owner": "Renovite" }` | no |

## Outputs

| Name | Description |
|------|-------------|
| cert\_arn | ARN of created certificate |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"