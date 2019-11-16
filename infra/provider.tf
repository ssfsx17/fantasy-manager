provider "aws" {}

terraform {
  backend "s3" {
    bucket = "x17-infra"
    key    = "terraform.tfstate"
  }
}
