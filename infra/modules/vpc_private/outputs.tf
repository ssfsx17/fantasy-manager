
// Read back variables and locals

output "public_vpc_id" {
  value = var.public_vpc_id
}

output "natgw_route_table_id" {
  value = var.natgw_route_table_id
}

output "natgw_ids" {
  value = var.natgw_ids
}

output "cidr" {
  value = var.cidr
}

output "az_letters" {
  value = var.az_letters
}

// Actual outputs

output "vpc" {
  value = aws_vpc.vpc
}

output "subnets" {
  value = aws_subnet.private
}

output "vpc_peering_connection" {
  value = aws_vpc_peering_connection.vpcpc
}

output "route_this_to_main_vpc" {
  value = aws_route.this_to_main_vpc
}

output "route_main_vpc_to_this" {
  value = aws_route.main_vpc_to_this
}

output "route_natgw_to_this" {
  value = aws_route.natgw_to_this
}
