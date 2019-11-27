
module "vpc_public" {
  source = "./modules/vpc_public"

  cidr    = cidrsubnet("10.0.0.0/8", 8, 0)
  ami_ids = var.ami_ids
}
