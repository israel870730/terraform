# EFS Module

This folder contains a simple Terraform module that deploys resources in [AWS](https://aws.amazon.com/).This module deploys [EFS](https://docs.aws.amazon.com/efs/latest/ug/getting-started.html) resources

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_security\_group | Whether a security group should be created | bool | `"true"` | no |
| efs\_encrypted | Whether encryption should be used | bool | `"true"` | no |
| efs\_name | efs name | string | `"efs-default"` | no |
| efs\_security\_group\_ids | security group ids for efs | list(string) | `[]` | no |
| environment | Environmen to create resources in | string | `"Dev"` | no |
| subnet\_tags | Tags to be attached to subnets | map | `{ "Name": "Private" }` | no |
| tags | generic tags | map(string) | `{}` | no |
| use\_default\_vpc | Whether the default vpc is used? | bool | `"false"` | no |
| vpc\_tags | vpc tags | map(string) | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name of the file system |
| dns\_name | The DNS name for the filesystem per documented convention |
| id | The ID that identifies the file system |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"