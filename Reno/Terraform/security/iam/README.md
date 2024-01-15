# IAM Module

This folder contains a simple Terraform module that deploys resources in [AWS](https://aws.amazon.com/).This module deploys [IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html) resources leveraging the official terraform registry module [terraform-aws-iam](https://github.com/terraform-aws-modules/terraform-aws-iam)

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_access\_key | Whether to create IAM access key | string | `"true"` | no |
| create\_role | Whether to create role | string | `"false"` | no |
| create\_user | Whether to create user | string | `"false"` | no |
| create\_user\_login\_profile | Whether to a UI access profile | string | `"false"` | no |
| custom\_role\_policy\_arn | List of ARNs of IAM policies to attach to IAM role | list | `[]` | no |
| environment | Environment Name | string | `"Dev"` | no |
| policy | The policy JSON data accepts template\(.tpl\) | string | `""` | no |
| policy\_description | The description of the policy | string | `"Renovite IAM Policy"` | no |
| policy\_name | Name of the policy | string | `"reno-iam-policy"` | no |
| policy\_path | The path in IAM | string | `"/"` | no |
| role\_name | Name of role | string | `"reno-iam-role"` | no |
| role\_path | Path of IAM role | string | `"/"` | no |
| role\_requires\_mfa | Whether role requires MFA | string | `"false"` | no |
| role\_tags | A map of tags to add to all role resources. | map | `{}` | no |
| trusted\_role\_arns | ARNs of AWS entities who can assume these roles | list | `[]` | no |
| user\_name | Name for IAM User | string | `"reno-iam-user"` | no |
| user\_tags | A map of tags to add to all user resources. | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| policy\_arn | ARN of created policy |
| policy\_id | ARN of created policy |
| role\_arn | ARN of created role |
| role\_name | Name of created role |
| user\_arn | ARN of created user |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"