# MYSQL

This module creates an [RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html) database running the `MySQL` engine leveraging the 
official terraform module [terraform-aws-rds](https://github.com/terraform-aws-modules/terraform-aws-rds)

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_security\_group | Create Security Group Access for Private subnets on port 3306 | bool
| defaults | Map with MySQL default settings | any
| environment | Environment name to deploy resources | string
| final\_snapshot\_identifier | ID that DB should be backed up to | string
| restore\_from\_snapshot | Whether to restore from snapshot | bool
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | bool
| snapshot\_identifier | Snapshot ID that DB should be restored from | string
| subnet\_tags | Subnet Tags to find database subnets | map
| tags | A mapping of tags to assign to all resources | map(string)
| use\_default\_vpc | Whether to use the default VPC - NOT recommended for production\(used for automated testing\)! | bool
| values | Map with MySQL custom settings, see defaults for options | any
| vpc\_tags | Tags used to find a vpc for building resources in | map(string)

## Outputs

| Name | Description |
|------|-------------|
| db\_instance\_id | DNS name of the RDS instance created |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"