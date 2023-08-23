# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  cloud {
    organization = "majordookie"

    workspaces {
      name = "battlebit"
    }
  }
}