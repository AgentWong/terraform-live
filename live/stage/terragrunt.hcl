remote_state {
  backend = "s3"

  config = {
    bucket = "terraform-up-and-running-state-4ecd0688"
    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}