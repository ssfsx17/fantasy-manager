
// Read back variables and locals

output "region" {
  value = var.region
}

output "cidr" {
  value = var.cidr
}

output "az_letters" {
  value = var.az_letters
}

output "public_cidr" {
  value = local.public_cidr
}

output "private_cidr" {
  value = local.private_cidr
}

// Actual outputs

output "vpc" {
  value = aws_vpc.vpc
}

output "internet_gateway" {
  value = aws_internet_gateway.gw
}

output "internet_gateway_route" {
  value = aws_route.igw
}

output "public_subnets" {
  value = aws_subnet.public
}

output "natgw_eips" {
  value = aws_eip.natgw
}

output "natgw" {
  value = aws_nat_gateway.gw
}

output "private_route_table" {
  value = aws_route_table.private
}

output "private_subnets" {
  value = aws_subnet.private
}

output "private_natgw_routes" {
  value = aws_route.private_natgw
}
