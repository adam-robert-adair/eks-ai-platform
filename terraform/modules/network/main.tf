module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = [for idx, az in var.availability_zones : cidrsubnet(var.vpc_cidr, 4, idx)]
  public_subnets  = [for idx, az in var.availability_zones : cidrsubnet(var.vpc_cidr, 4, idx + 8)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}
