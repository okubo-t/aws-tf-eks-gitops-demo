resource "aws_iam_user" "argocd_sync" {
  name = "${var.prefix}-${var.env}-argocd-sync"
}

resource "aws_iam_user_policy" "for_argocd_sync" {
  name = "${var.prefix}-${var.env}-argocd-sync"
  user = aws_iam_user.argocd_sync.name

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "codecommit:GitPull"
        ],
        Resource : aws_codecommit_repository.k8s.arn
      }
    ]
  })
}

resource "aws_iam_service_specific_credential" "argocd_sync" {
  service_name = "codecommit.amazonaws.com"
  user_name    = aws_iam_user.argocd_sync.name
}
