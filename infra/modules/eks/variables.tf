
variable "cluster_name" {
  type = string
}

variable "public_endpoint" {
  type = bool
}

variable "subnet_ids" {
  type = list(string)
}
