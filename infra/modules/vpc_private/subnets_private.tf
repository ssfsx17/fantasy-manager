
// Private route tables - the only ones that should ever get VPC-linked
resource "aws_route_table" "private" {
  count = length(local.availability_zones)

  vpc_id = aws_vpc.vpc.id
}

// Private subnets
resource "aws_subnet" "private" {
  count = length(local.availability_zones)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.private_cidr, 3, count.index)
  availability_zone = local.availability_zones[count.index]

  tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "aws_route_table_association" "private" {
  count = length(local.availability_zones)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}

resource "aws_route" "private_to_target" {
  count = length(local.availability_zones)

  route_table_id            = aws_route_table.private[count.index].id
  destination_cidr_block    = "0.0.0.0/0"
  vpc_peering_connection_id = aws_vpc_peering_connection.to_target
}

resource "aws_route" "target_to_private" {
  for_each = var.target_vpc_route_table_ids

  route_table_id            = each.key
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.to_target
}
