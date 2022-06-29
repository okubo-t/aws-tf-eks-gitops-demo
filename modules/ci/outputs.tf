output "CODECOMMIT_IMAGE_REPOSITORY_URL" {
  value = aws_codecommit_repository.image.clone_url_http
}

output "CODECOMMIT_INFRA_REPOSITORY_URL" {
  value = aws_codecommit_repository.k8s.clone_url_http
}

output "argocd_sync_username" {
  value = aws_iam_service_specific_credential.argocd_sync.service_user_name
}

output "argocd_sync_password" {
  value = aws_iam_service_specific_credential.argocd_sync.service_password
}

output "ecr_repository" {
  value = aws_ecr_repository.this.repository_url
}
