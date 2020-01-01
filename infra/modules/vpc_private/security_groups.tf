
resource "aws_security_group" "private" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "bastion_ssh_egress_to_private" {
  security_group_id        = var.target_vpc_sg_bastion
  source_security_group_id = aws_security_group.private.id

  type      = "egress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}

resource "aws_security_group_rule" "private_ssh_ingress_from_bastion" {
  security_group_id        = aws_security_group.private.id
  source_security_group_id = var.target_vpc_sg_bastion

  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}
