
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "private" {
  count = length(var.az_letters)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr, 3, count.index)
  availability_zone = "${var.region}${var.az_letters[count.index]}"
}

// setup NAT gateway access

data "aws_vpc" "public" {
  id = var.public_vpc_id
}

resource "aws_vpc_peering_connection" "vpcpc" {
  vpc_id      = aws_vpc.vpc.id
  peer_vpc_id = var.public_vpc_id
  auto_accept = true
}

resource "aws_route" "this_to_main_vpc" {
  route_table_id            = aws_vpc.vpc.main_route_table_id
  destination_cidr_block    = data.aws_vpc.public.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpcpc.id
}

resource "aws_route" "main_vpc_to_this" {
  route_table_id            = var.natgw_route_table_id
  destination_cidr_block    = var.cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpcpc.id
}

resource "aws_route" "natgw_to_this" {
  for_each = var.natgw_ids

  route_table_id         = var.natgw_route_table_id
  destination_cidr_block = var.cidr
  nat_gateway_id         = each.value
}
