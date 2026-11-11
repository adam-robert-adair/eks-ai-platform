module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.public_subnet_ids

  enable_irsa = true

  create_cloudwatch_log_group = true
  cluster_enabled_log_types   = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  cluster_addons = {
    coredns            = {}
    kube-proxy         = {}
    vpc-cni            = {}
    aws-ebs-csi-driver = {}
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = merge(
    {
      Name = var.cluster_name
    },
    var.additional_tags
  )
}
