#Ejemplo para count
variable "usuarios" {
    //type        = list(string)
    //default = [ "karla", "israel", "qki", "aida" ]
    type = number
    default = 5
    description = "Lista de nombres que llama el count"
}

#Ejemplo para for_each
/*variable "usuarios" {
    type        = set(string)
    description = "Lista de nombres que llama el for_each"
    default = [ "israel", "karla" ]
}*/