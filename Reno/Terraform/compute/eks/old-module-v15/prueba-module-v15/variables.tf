variable cluster_name {
  description = "Name EKS cluster is created with"
  type        = string
}

variable "cluster_version" {
  description = "EKS cluster version to use"
  type        = string
  default     = "1.12"
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

variable "tags" {
  description = "A map of tags that get added to all resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "Region"
  type = string
  default = ""
}
