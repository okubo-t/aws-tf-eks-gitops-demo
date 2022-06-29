variable "prefix" {}
variable "env" {}
variable "codecommit_repository_for_image" {}
variable "branch_name" {}
variable "ecr_name" {}
variable "codecommit_repository_for_k8s" {}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
