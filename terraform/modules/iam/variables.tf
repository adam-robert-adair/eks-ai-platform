variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_oidc_subjects" {
  type = list(string)
}

variable "ecr_repository_arn" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_oidc_provider_arn" {
  type = string
}

variable "cluster_oidc_issuer_url" {
  type = string
}

variable "external_secret_arn_prefix" {
  type = string
}
