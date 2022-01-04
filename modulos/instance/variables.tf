variable "ami_id" {
  default     = ""
  description = "Ami Id"
}
variable "instance_type" {
  description = "Public key path"

}
variable "tags" {
  description = "Variable para los tags"
  type        = map(any)
}
variable "key_name" {
  description = "Llave publica"

}
variable "public_key" {
  description = "Public key path"

}
variable "instance_count" {
  description = "Cantidad de intancias"

}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with."
  type        = list(string)
  default     = []
}