variable "ami_id" {
  default=""
  description = "Ami Id"
}
variable "instance_type" {
  
}
variable "tags" {
  type = map
}
variable "key_name" {
  
}
variable "public_key"{
description = "Public key path"
}
variable "sg_name" {

}
variable "ingress_rules" {

}
variable "instance_count" {

}
variable "egress_rules" {

}
