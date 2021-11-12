variable "bucket_name" {
  default= "catalogo-auto"
}

variable "acl" {
  default = "private"
}

variable "tags" {
  default = {Enviroment = "Dev", CreateBy = "catalogo"}
}
