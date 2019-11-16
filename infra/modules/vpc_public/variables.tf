variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cidr" {
  type    = string
  default = cidrsubnet("10.0.0.0/8", 8, 0)
}

variable "az_letters" {
  type    = list(string)
  default = ["a", "b", "c", "d"]
}

locals {
  public_cidr  = cidrsubnet(var.cidr, 1, 0)
  private_cidr = cidrsubnet(var.cidr, 1, 1)
}
