# MYSQL

This module creates an [RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html) database running the `MySQL` engine leveraging the 
official terraform module [terraform-aws-rds](https://github.com/terraform-aws-modules/terraform-aws-rds)

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_security\_group | Create Security Group Access for Private subnets on port 3306 | bool | `"true"` | no |
| defaults | Map with MySQL default settings | any | `{ "allocated_storage": 10, "allow_major_version_upgrade": false, "auto_minor_version_upgrade": false, "backup_window": "01:00-01:30", "deletion_protection": false, "engine": "mysql", "engine_version": "8.0.13", "family": "mysql8.0", "identifier": "renodemo", "instance_class": "db.t3.large", "maintenance_window": "Mon:02:00-Mon:05:00", "major_engine_version": "8.0", "multi_az": false, "option_group_name": "default:mysql-8-0", "parameter_group_name": "default.mysql8.0", "password": "changeme", "port": "3306", "storage_encrypted": false, "username": "demouser" }` | no |
| environment | Environment name to deploy resources | string | `"Dev"` | no |
| final\_snapshot\_identifier | ID that DB should be backed up to | string | `"null"` | no |
| restore\_from\_snapshot | Whether to restore from snapshot | bool | `"false"` | no |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final\_snapshot\_identifier | bool | `"true"` | no |
| snapshot\_identifier | Snapshot ID that DB should be restored from | string | `"null"` | no |
| subnet\_tags | Subnet Tags to find database subnets | map | `{ "Name": "Isolated" }` | no |
| tags | A mapping of tags to assign to all resources | map(string) | `{}` | no |
| use\_default\_vpc | Whether to use the default VPC - NOT recommended for production\(used for automated testing\)! | bool | `"false"` | no |
| values | Map with MySQL custom settings, see defaults for options | any | `{}` | no |
| vpc\_tags | Tags used to find a vpc for building resources in | map(string) | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| db\_instance\_id | DNS name of the RDS instance created |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"