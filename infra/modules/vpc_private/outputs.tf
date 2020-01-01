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

output "target_vpc_id" {
  value = var.target_vpc_id
}

output "target_vpc_sg_bastion" {
  value = var.target_vpc_sg_bastion
}

// Actual outputs

output "vpc" {
  value = aws_vpc.vpc
}

output "security_group" {
  value = aws_security_group.private
}

output "route_tables" {
  value = aws_route_table.private
}

output "subnets" {
  value = aws_subnet.private
}

output "route_table_associations" {
  value = aws_route_table_association.private
}

output "private_routes_to_vpclink" {
  value = aws_route.private_to_target
}

output "target_routes_to_vpclink" {
  value = aws_route.target_to_private
}
