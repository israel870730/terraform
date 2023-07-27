variable "region" {
  description = "Region"
  type = string
  default = ""
}

variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags that get added to all resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = null
}