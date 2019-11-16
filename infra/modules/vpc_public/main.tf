
// VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
}

// Public IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "igw" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = local.public_cidr
  gateway_id             = aws_internet_gateway.gw.id
}

// Public subnets
resource "aws_subnet" "public" {
  count = length(var.az_letters)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.public_cidr, 3, count.index)
  availability_zone = "${var.region}${var.az_letters[count.index]}"
}

resource "aws_eip" "natgw" {
  public_ipv4_pool = "amazon"
  vpc              = true

  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_route_table_association" "public" {
  count = length(var.az_letters)

  route_table_id = aws_vpc.vpc.main_route_table_id
  subnet_id      = aws_subnet_public[count.index].id
}

resource "aws_nat_gateway" "gw" {
  count = length(var.az_letters)

  allocation_id = aws_eip.natgw[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
}

// Private route table - the only one that should ever get VPC-linked
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
}

// Private subnets for NAT gateway only, no IGW
resource "aws_subnet" "private" {
  count = length(var.az_letters)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.private_cidr, 3, count.index)
  availability_zone = "${var.region}${var.az_letters[count.index]}"
}

resource "aws_route_table_association" "private" {
  count = length(var.az_letters)

  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet_private[count.index].id
}

resource "aws_route" "private_natgw" {
  count = length(var.az_letters)

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = local.private_cidr
  nat_gateway_id         = aws_nat_gateway.gw[count.index].id
}
