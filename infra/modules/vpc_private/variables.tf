variable "public_vpc_id" {
  type        = string
  description = "public VPC ID"
}

variable "natgw_route_table_id" {
  type        = string
  description = "NAT gateway route table ID - existing in the public VPC"
}

variable "natgw_ids" {
  type        = list(string)
  description = "list of NAT gateway IDs - existing in the public VPC"
}

variable "cidr" {
  type    = string
  default = cidrsubnet("10.0.0.0/8", 8, 1)
}

variable "az_letters" {
  type    = list(string)
  default = ["a", "b", "c", "d"]
}
