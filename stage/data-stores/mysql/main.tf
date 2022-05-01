provider "aws" {
    region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-4ecd0688"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

resource "aws_db_instance" "example2" {
    identifier_prefix = "terraform-up-and-running"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    name = "example_database"
    username = "admin"

    password = data.aws_secretsmanager_secret_version.db_password.secret_string
}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = aws_secretsmanager_secret.example2.id
}

resource "aws_secretsmanager_secret" "example2" {
  name = "example2"
}
resource "aws_secretsmanager_secret_version" "example2" {
  secret_id     = aws_secretsmanager_secret.example2.id
  secret_string = "example-string-to-protect-1337"
}