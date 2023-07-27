variable "region" {
  description = "Region"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "EKS cluster version to use"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID for the VPC to deploy EKS cluster"
  type        = string
  default     = ""
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

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}