output "CODECOMMIT_IMAGE_REPOSITORY_URL" {
  value = module.ci.CODECOMMIT_IMAGE_REPOSITORY_URL
}

output "CODECOMMIT_INFRA_REPOSITORY_URL" {
  value = module.ci.CODECOMMIT_INFRA_REPOSITORY_URL
}

output "ECR_REPOSITORY_URL" {
  value = module.ci.ecr_repository
}

output "argocd_sync_username" {
  value     = module.ci.argocd_sync_username
  sensitive = true
}

output "argocd_sync_password" {
  value     = module.ci.argocd_sync_password
  sensitive = true
}

output "eks_cluster_name" {
  value = "eks-gitops-demo"
}

output "app_name" {
  value = "eks-gitops-demo-app"
}
