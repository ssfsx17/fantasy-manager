
resource "aws_security_group" "public" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "bastion" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "private" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "bastion_ssh_ingress_from_world" {
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}

resource "aws_security_group_rule" "bastion_ssh_egress_to_public" {
  security_group_id        = aws_security_group.bastion.id
  source_security_group_id = aws_security_group.public.id

  type      = "egress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}

resource "aws_security_group_rule" "bastion_ssh_egress_to_private" {
  security_group_id        = aws_security_group.bastion.id
  source_security_group_id = aws_security_group.private.id

  type      = "egress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}

resource "aws_security_group_rule" "public_ssh_ingress_from_bastion" {
  security_group_id        = aws_security_group.public.id
  source_security_group_id = aws_security_group.bastion.id

  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}

resource "aws_security_group_rule" "private_ssh_ingress_from_bastion" {
  security_group_id        = aws_security_group.private.id
  source_security_group_id = aws_security_group.bastion.id

  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
}

resource "aws_security_group_rule" "private_all_egress_to_public" {
  security_group_id        = aws_security_group.private.id
  source_security_group_id = aws_security_group.public.id

  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "all"
}

resource "aws_security_group_rule" "public_all_ingress_from_private" {
  security_group_id        = aws_security_group.public.id
  source_security_group_id = aws_security_group.private.id

  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "all"
}

resource "aws_security_group_rule" "bastion_http_egress_to_world" {
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "egress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
}

resource "aws_security_group_rule" "bastion_https_egress_to_world" {
  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "egress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
}

resource "aws_security_group_rule" "public_http_egress_to_world" {
  security_group_id = aws_security_group.public.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "egress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
}

resource "aws_security_group_rule" "public_https_egress_to_world" {
  security_group_id = aws_security_group.public.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "egress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
}

resource "aws_security_group_rule" "public_http_ingress_from_world" {
  security_group_id = aws_security_group.public.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
}

resource "aws_security_group_rule" "public_https_ingress_from_world" {
  security_group_id = aws_security_group.public.id
  cidr_blocks       = ["0.0.0.0/0"]

  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
}
