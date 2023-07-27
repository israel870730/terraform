variable cluster_name {
  description = "Name EKS cluster is created with"
  type        = string
}

variable "cluster_version" {
  description = "EKS cluster version to use"
  type        = string
  default     = "1.12"
}

variable "efs_name" {
  description = "efs name"
  type        = string
  default     = ""
}

variable "config_output_path" {
  description = "Where to write Kubectl config "
  type        = string
  default     = "./"
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "Dev"
}

variable "manage_aws_auth" {
  description = "Whether to apply the aws-auth configmap file."
  type        = string
  default     = "true"
}

variable "map_users" {
  description = "Users that have access to the cluster"
  type        = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
}

variable "public_subnet_tags" {
  description = "Subnet Tags to find database subnets"
  type        = map
  default = {
    Name = "Public"
  }
}

variable "private_subnet_tags" {
  description = "Subnet Tags to find database subnets"
  type        = map
  default = {
    Name = "Private"
  }
}

variable "subnets" {
  description = "Subnets that run the EKS Worker Nodes"
  type        = list(string)
  default     = null
}


variable "tags" {
  description = "A map of tags that get added to all resources"
  type        = map(string)
  default     = {}
}

variable "use_default_vpc" {
  description = "Whether to use the default VPC - NOT recommended for production(used for automated testing)!"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "ID for the VPC to deploy EKS cluster"
  type        = string
  default     = ""
}

variable "worker_groups" {
  description = "ASG worker group settings for K8s Nodes"
  type        = any
  default     = {}
}

variable "workgroup_subnets" {
  description = "The subnets where K8s worker nodes run"
  type        = list(string)
  default     = null
}

variable "write_kubeconfig" {
  description = "Whether to write the kubeconfig file or not"
  type        = bool
  default     = true
}

variable "write_aws_auth_config" {
  description = "Whether to write the aws_auth_config"
  type        = bool
  default     = "true"
}

variable "vpc_remote_state_key" {
  description = "Key Path for VPC remote state"
  type        = string
  default     = "vpc/terraform.tfstate"
}

variable "vpc_tags" {
  description = "Tags used to find a vpc for building resources in"
  type        = map(string)
  default     = {}
}

variable "worker_ami_owner_id" {
  description = "The ID of the owner for the AMI to use for the AWS EKS workers. Valid values are an AWS account ID, 'self' (the current account), or an AWS owner alias (e.g. 'amazon', 'aws-marketplace', 'microsoft')."
  type        = string
  default     = "679593333241" // The ID of the owner of the official AWS EKS AMIs.
}

variable "worker_ami_owner_id_windows" {
  description = "The ID of the owner for the AMI to use for the AWS EKS Windows workers. Valid values are an AWS account ID, 'self' (the current account), or an AWS owner alias (e.g. 'amazon', 'aws-marketplace', 'microsoft')."
  type        = string
  default     = "679593333241" // The ID of the owner of the official AWS EKS Windows AMIs.
}

variable "map_roles" {
  description = "Roles that have access to the cluster"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "manage_cluster_iam_resources" {
  description = "Whether to let the module manage cluster IAM resources. If set to false, cluster_iam_role_name must be specified."
  type        = bool
  default     = true
}

variable "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  type        = string
  default     = ""
}

variable "manage_worker_iam_resources" {
  description = "Whether to let the module manage worker IAM resources. If set to false, iam_instance_profile_name must be specified for workers."
  type        = bool
  default     = true
}

variable "workers_role_name" {
  description = "Default IAM instance profile ARN for EKS worker groups"
  type        = string
  default     = ""
}

variable "region" {
  description = "Region"
  type = string
  default = ""
}