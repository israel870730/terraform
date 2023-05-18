variable "region" {
  description = "Region"
  type = string
  default = ""
}
variable cluster_name {
  description = "Name EKS cluster is created with"
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "EKS cluster version to use"
  type        = string
  default     = ""
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID for the VPC to deploy EKS cluster"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "Subnets that run the EKS Worker Nodes"
  type        = list(string)
  default     = null
}

variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}

variable "manage_aws_auth_configmap" {
  description = "Determines whether to manage the aws-auth configmap"
  type        = bool
  default     = true
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["audit", "api", "authenticator","controllerManager","scheduler"]
}

variable "tags" {
  description = "A map of tags that get added to all resources"
  type        = map(string)
  default     = {}
}

variable "aws_auth_roles" {
  description = "List of role maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}
