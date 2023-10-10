variable "tags" {
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
  type        = map(string)
  default     = {
    Name = "demo"
    Env  = "poc"
  }
}