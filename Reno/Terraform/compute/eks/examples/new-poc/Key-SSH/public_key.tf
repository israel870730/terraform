# RSA key of size 4096 bits
resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "public_key_openssh" {
  value = tls_private_key.rsa-4096-example.public_key_openssh
}