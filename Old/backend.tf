#Aqui se define donde quiero guardar el estado de mi infraestructura, en este caso estoy usando un backet de S3 y una tabla en DynamoDB

#terraform {
#  backend "s3" {
#    bucket = "safe-state-terraform"
#    key    = "dev/state"
#    region = "us-east-1"
#    encrypt = true
#    dynamodb_table = "safe-state-terraform"
#    kms_key_id = "arn:aws:kms:us-east-1:304959390434:key/7a0ede15-f366-4387-b3e2-f3a38cdda135"
#  }
#}
