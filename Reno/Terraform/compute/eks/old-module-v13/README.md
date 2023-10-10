# EKS Module

This module creates an `AWS` [EKS]() cluster leveraging the official
terraform module [terraform-aws-eks](https://github.com/terraform-aws-modules/terraform-aws-eks) 

[/]: / "<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_version | EKS cluster version to use | string
| config\_output\_path | Where to write Kubectl config | string
| environment | Environment Name | string
| manage\_aws\_auth | Whether to apply the aws-auth configmap file. | string
| map\_users | Users that have access to the cluster | list(map(string))
| private\_subnet\_tags | Subnet Tags to find database subnets | map
| public\_subnet\_tags | Subnet Tags to find database subnets | map
| subnets | Subnets that run the EKS Worker Nodes | list(string)
| tags | A map of tags that get added to all resources | map(string)
| use\_default\_vpc | Whether to use the default VPC - NOT recommended for production\(used for automated testing\)! | bool
| vpc\_id | ID for the VPC to deploy EKS cluster | string
| vpc\_remote\_state\_key | Key Path for VPC remote state | string
| vpc\_tags | Tags used to find a vpc for building resources in | map(string)
| worker\_groups | ASG worker group settings for K8s Nodes | any
| workgroup\_subnets | The subnets where K8s worker nodes run | list(string)
| write\_aws\_auth\_config | Whether to write the aws\_auth\_config | bool
| write\_kubeconfig | Whether to write the kubeconfig file or not | bool

[/]: / "<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->"