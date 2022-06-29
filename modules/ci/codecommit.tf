resource "aws_codecommit_repository" "image" {
  repository_name = var.codecommit_repository_for_image
}

resource "aws_codecommit_repository" "k8s" {
  repository_name = var.codecommit_repository_for_k8s
}
