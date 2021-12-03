provider "aws" {
  region = "us-east-1"
}
#Este bucket esta listo para guardar el estado de la infra de terraform de forma encryptada
resource "aws_s3_bucket" "catalogo-auto" {
  bucket = var.bucket
  acl = var.acl
  tags = var.tags
  #Si habilito este tag prohibo que se pueda eliminar el bucket
  #lifecycle {
   # prevent_destroy = true
  #}
  #force_destroy = true
  #Si habilito esta opcion despues tengo que ir al bucket y borrar los ficheros a mano pq da error y no se deja eliminar mediante terraform
  #versioning {
   # enabled = true
  #}
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
     }
    }
  }
}
resource "aws_kms_key" "mykey" {
  description             = "Llave para encryptar el archivo de estado"
  deletion_window_in_days = 10
}

output "arn" {
  value = aws_kms_key.mykey.arn
}

#Aqui creo la tabla de dynamoDB que me va a impedir que dos personas trabajen a la ves en la infra
#locking part

resource "aws_dynamodb_table" "tf_remote_state_locking" {
  hash_key = "LockID"
  name = "safe-state-terraform"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
