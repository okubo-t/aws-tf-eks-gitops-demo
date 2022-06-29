resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/aws/codebuild/${var.prefix}-${var.env}-project"
  retention_in_days = 30
}
