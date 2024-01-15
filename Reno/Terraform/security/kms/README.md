# KMS Module

This folder contains a simple Terraform module that deploys resources in [AWS](https://aws.amazon.com/).This module deploys [KMS](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html) resources

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alias\_name | Name of key alias | string | `"renovite-key"` | no |
| alias\_target\_key\_id | Identifier for the key for which the alias is for, ARN or key\_id accepted | string | `""` | no |
| create\_alias | Whether to create key alias | bool | `"true"` | no |
| create\_grant | Whether to create grant | bool | `"false"` | no |
| create\_key | Whether to create key | bool | `"true"` | no |
| environment | Environmen to create resources in | string | `"Dev"` | no |
| grant\_operations | A list of operations that the grant permits | list(string) | `[ "Encrypt", "Decrypt", "DescribeKey", "GenerateDataKey" ]` | no |
| grant\_principal | The principal that is given permission to perform the operations that the grant permits in ARN format | string | `""` | no |
| key\_deletion\_window | Duration in days after which the key is deleted | number | `"7"` | no |
| key\_description | The description for the key | string | `"Renovite KMS Key"` | no |
| key\_enable\_rotation | Whether to enable key rotation | bool | `"false"` | no |
| key\_enabled | Whether key is enabled | bool | `"true"` | no |
| key\_usage | Specifies the intended use of the key, only symmetric encryption and decryption are supported | string | `"ENCRYPT_DECRYPT"` | no |
| policy | A valid policy JSON document to associate with KMS resources | string | `""` | no |
| tags | A mapping of tags to assign to the KMS resources | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| alias\_arn | The ARN for the key alias |
| grant\_id | The unique identifier for the grant |
| grant\_token | The grant token for the created grant |
| key\_arn | The ARN of the key |
| key\_id | The globally unique identifier for the key |

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"