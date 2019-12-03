
// VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
