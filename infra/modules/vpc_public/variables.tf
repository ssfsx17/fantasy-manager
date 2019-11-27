variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "az_letters" {
  type    = list(string)
  default = ["a", "b", "c", "d"]
}

variable "ami_ids" {
  type = map(string)
}

locals {
  public_cidr        = cidrsubnet(var.cidr, 1, 0)
  private_cidr       = cidrsubnet(var.cidr, 1, 1)
  availability_zones = formatlist("%s%s", var.region, var.az_letters)
}
