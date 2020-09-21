remote_state {
  backend = "s3"
  config = {
    bucket         = "tccdev-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path        = "provider.tf"
  if_exists   = "overwrite_terragrunt"
  contents    = <<EOF
    provider "aws" {
      region  = "eu-north-1"
      version = "~> 2.0"
    }
              EOF
}
