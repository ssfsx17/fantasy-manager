
// Public IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "igw" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

// Public subnets
resource "aws_subnet" "public" {
  count = length(local.availability_zones)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.public_cidr, 3, count.index)
  availability_zone = local.availability_zones[count.index]

  tags = {
    "kubernetes.io/role/elb" = "1"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "aws_eip" "natgw" {
  count = length(local.availability_zones)

  public_ipv4_pool = "amazon"
  vpc              = true

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table_association" "public" {
  count = length(local.availability_zones)

  route_table_id = aws_vpc.vpc.main_route_table_id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_nat_gateway" "gw" {
  count = length(local.availability_zones)

  allocation_id = aws_eip.natgw[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
}
