# Root Example

This module deploys [EFS](https://docs.aws.amazon.com/efs/latest/ug/getting-started.html) resources in [AWS](https://aws.amazon.com/).

**WARNING**: This module and the automated tests for it deploy real resources into our AWS account which costs money. 


## Running this module manually

1. Sign up for [AWS](https://aws.amazon.com/).
2. Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
3. Set the AWS region you want to use as the environment variable `AWS_DEFAULT_REGION`.
4. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
5. Run `terraform init`.
6. Run `terraform apply`.
7. When you're done, run `terraform destroy`.
   
## Running automated tests against this module

1. Sign up for [AWS](https://aws.amazon.com/).
2. Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
3. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
4. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
5. `cd test`
6. `dep ensure`
7. `go test -v -run TestRootExample`

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| efs\_name | efs name | string | `"root-example"` | no |

## Outputs

| Name | Description |
|------|-------------|
| efs\_arn | The Amazon Resource Name of the file system |
| efs\_id | The Amazon Resource Name of the file system |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"