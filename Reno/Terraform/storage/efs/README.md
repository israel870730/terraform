# EFS Module

This folder contains a simple Terraform module that deploys resources in [AWS](https://aws.amazon.com/).This module deploys [EFS](https://docs.aws.amazon.com/efs/latest/ug/getting-started.html) resources

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_security\_group | Whether a security group should be created | bool
| efs\_encrypted | Whether encryption should be used | bool
| efs\_name | efs name | string
| efs\_security\_group\_ids | security group ids for efs | list(string)
| environment | Environmen to create resources in | string
| subnet\_tags | Tags to be attached to subnets | map
| tags | generic tags | map(string)
| use\_default\_vpc | Whether the default vpc is used? | bool
| vpc\_tags | vpc tags | map(string)

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name of the file system |
| dns\_name | The DNS name for the filesystem per documented convention |
| id | The ID that identifies the file system |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"