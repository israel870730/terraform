variable "ami_id" {
  default=""
  description = "Ami Id"
}
variable "instance_type" {
description = "Public key path"
  
}
variable "tags" {
description = "Variable para los tags"
  type = map
}
variable "key_name" {
description = "Llave publica"

}
variable "public_key"{
description = "Public key path"

}
variable "sg_name" {
description = "Grupo de sguridad"

}
variable "ingress_rules" {
description = "Ingress"

}
variable "instance_count" {
description = "Cantidad de intancias"

}
variable "egress_rules" {
description = "Egress"

}
