
// Private route tables - the only ones that should ever get VPC-linked
resource "aws_route_table" "private" {
  count = length(local.availability_zones)

  vpc_id = aws_vpc.vpc.id
}

// Private subnets for NAT gateway only, no IGW
resource "aws_subnet" "private" {
  count = length(local.availability_zones)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.private_cidr, 3, count.index)
  availability_zone = local.availability_zones[count.index]
}

resource "aws_route_table_association" "private" {
  count = length(local.availability_zones)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}

resource "aws_route" "private_natgw" {
  count = length(local.availability_zones)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw[count.index].id
}
