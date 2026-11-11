module "network" {
  source = "./modules/network"

  name               = local.name_prefix
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = "${local.name_prefix}-langgraph"
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = local.name_prefix
  cluster_version    = var.cluster_version
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_ids  = module.network.public_subnet_ids
  additional_tags    = var.additional_tags
}

module "iam" {
  source = "./modules/iam"

  project_name = local.name_prefix
  aws_region   = var.aws_region
  github_owner = var.github_owner
  github_repo  = var.github_repo
  github_oidc_subjects = [
    "repo:${var.github_owner}/${var.github_repo}:ref:refs/heads/main",
    "repo:${var.github_owner}/${var.github_repo}:pull_request"
  ]
  ecr_repository_arn         = module.ecr.repository_arn
  cluster_name               = module.eks.cluster_name
  cluster_oidc_provider_arn  = module.eks.oidc_provider_arn
  cluster_oidc_issuer_url    = module.eks.cluster_oidc_issuer_url
  external_secret_arn_prefix = var.external_secret_arn_prefix
}

resource "aws_budgets_budget" "monthly" {
  name         = "${local.name_prefix}-monthly"
  budget_type  = "COST"
  limit_amount = var.budget_limit_usd
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.budget_alert_email]
  }
}

resource "aws_eks_access_entry" "github_ci" {
  cluster_name  = module.eks.cluster_name
  principal_arn = module.iam.github_actions_role_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_ci_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = module.iam.github_actions_role_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
