variable "aws_region" {
  description = "AWS region to deploy infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "eks-ai-platform"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for the VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cluster_version" {
  description = "EKS cluster Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "github_owner" {
  description = "GitHub organization or user"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "budget_limit_usd" {
  description = "Monthly budget limit in USD"
  type        = string
  default     = "75"
}

variable "budget_alert_email" {
  description = "Email to receive budget alerts"
  type        = string
}

variable "external_secret_arn_prefix" {
  description = "Secrets Manager ARN prefix External Secrets can read"
  type        = string
  default     = "arn:aws:secretsmanager:*:*:secret:/eks-ai-platform/*"
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
