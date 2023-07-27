resource "aws_key_pair" "deployer" {
  key_name   = "k8s-poc-key"
  public_key = tls_private_key.rsa-4096-example.public_key_openssh
}