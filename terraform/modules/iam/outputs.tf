output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "external_secrets_role_arn" {
  value = aws_iam_role.external_secrets.arn
}
