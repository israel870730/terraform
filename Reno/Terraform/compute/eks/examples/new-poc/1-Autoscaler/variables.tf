variable "region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = ""  
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = ""
}

variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = ""
}
