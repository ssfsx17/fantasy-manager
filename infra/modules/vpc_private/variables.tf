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

variable "target_vpc_id" {
  type        = string
  description = "target VPC that is allowed to interface with the public"
}

variable "target_vpc_sg_bastion" {
  type        = string
  description = "security group ID in the target VPC that has SSH bastions"
}

variable "target_vpc_route_table_ids" {
  type        = list(string)
  description = "list of route table IDs in the target VPC that need to know about the VPC link"
}

locals {
  availability_zones = formatlist("%s%s", var.region, var.az_letters)
}
