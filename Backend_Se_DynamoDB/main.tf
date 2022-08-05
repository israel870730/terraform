#############################################################################
#  Definimos el backend que vamos a usar para respaldar la infraestructura  #
#############################################################################
terraform {
  backend "s3"{
    bucket = "israel870730-curso-terraform-udemy"
    //Aqui se puede definir una ruta diferente para cada entorno
    key    = "aws/terraform.tfstate"
    region =  "us-east-1"

    dynamodb_table = "tf-israel870730-curso-terraform-udemy-locks"
    encrypt         = true 
  }
}

###########################
#  Definir el provider   ##
###########################
provider "aws" {
  region = "us-east-1"
}

###########################
#  Creamos el bucket S3   #
###########################
resource "aws_s3_bucket" "terraform_state" {
  bucket = "israel870730-curso-terraform-udemy"

  lifecycle {
    // Con este tag me aseguro de que el bucket nunca sea eliminado, muy importante pq tengo el estado aqui
    prevent_destroy = true
  }

  versioning {
    //Activo el versionado del bucket
    enabled = true
  }

  server_side_encryption_configuration {
    //Le activo la ecryptacion en los disco de S3
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

#################################
#  Creamos la tabla en dynamodb #
#################################
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-israel870730-curso-terraform-udemy-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    //Columna
    name = "LockID"
    type = "S"
  }
}
/*
resource "aws_instance" "servidor" {
  instance_type = "t2.micro"
  ami           = "ami-052efd3df9dad4825" 
}*/