provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      {
        Project     = "eks-ai-platform"
        Environment = var.environment
        ManagedBy   = "terraform"
      },
      var.additional_tags
    )
  }
}
