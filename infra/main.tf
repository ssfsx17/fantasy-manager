
module "vpc_public" {
  source = "./modules/vpc_public"

  cidr        = cidrsubnet("10.0.0.0/8", 8, 0)
  ami_ids     = var.ami_ids
  bastion_key = "admin_ssh"
}

module "eks_public" {
  source = "./modules/eks"

  cluster_name    = "public_facing"
  public_endpoint = true
  subnet_ids      = concat(module.vpc_public.public_subnets.*.id, module.vpc_public.private_subnets.*.id)
}
