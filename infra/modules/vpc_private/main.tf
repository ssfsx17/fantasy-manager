
// VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "aws_vpc_peering_connection" "to_target" {
  vpc_id      = aws_vpc.vpc.id
  peer_vpc_id = var.target_vpc_id
  auto_accept = true
}
