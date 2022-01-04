variable "ami_id" {
  default     = ""
  description = "Ami Id"
}
variable "instance_type" {

}
variable "tags" {
  type = map(any)
}
variable "key_name" {

}
variable "public_key" {
  description = "Public key path"
}
variable "name" {

}
variable "ingress_rules" {

}
variable "instance_count" {

}
variable "egress_rules" {

}
variable "bucket" {
  description = "Nombre del Bucket"
}

variable "acl" {
  description = "Permisos del bucket"
}

variable "tags_s3" {
  description = "Tags del Bucket"
}

#variable "this_security_group_id" {
#  description = "this_security_group_id"
#}
