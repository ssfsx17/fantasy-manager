provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "x17-infra"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
