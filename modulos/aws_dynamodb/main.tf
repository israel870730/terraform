resource "aws_dynamodb_table" "employee_test" {
  name           = "EmployeeTest2021"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "EmployeeID"

  attribute {
    name = "EmployeeID"
    type = "S"
  }

  attribute {
    name = "Q1"
    type = "S"
  }

  attribute {
    name = "Q2"
    type = "S"
  }

  attribute {
    name = "Q3"
    type = "S"
  }

  attribute {
    name = "Q4"
    type = "S"
  }

  attribute {
    name = "Q5"
    type = "S"
  }

  tags = {
    Name        = "employment_test"
    Environment = "production"
  }
}
