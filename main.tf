locals {
  aws_profile = "YOUR AWS ACCOUNT PROFILE NAME"
  aws_region  = "ap-northeast-1"
}

module "ci" {
  source = "./modules/ci"

  # PREFIX
  prefix = "eks-gitops"
  # ENVIRONMENT PREFIX
  env = "demo"

  # IMAGE CODECOMMIT REPOSITORY NAME
  codecommit_repository_for_image = "eks-gitops-demo-app"
  # BRANCH NAME
  branch_name = "master"
  # ECR REPOSITORY NAME
  ecr_name = "eks-gitops-demo-app"

  # K8S CODECOMMIT REPOSITORY NAME
  codecommit_repository_for_k8s = "eks-gitops-demo-k8s"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  # VPC NAME
  name = "eks-gitops-demo-vpc"
  # VPC CIDR
  cidr = "10.0.0.0/16"
  # SUBNET
  azs             = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  # NAT GATEWAY
  enable_nat_gateway = true
  single_nat_gateway = true
  # DNS
  enable_dns_hostnames = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.0"

  # EKS CONTROL PLANE 
  cluster_name                    = "eks-gitops-demo"
  cluster_version                 = "1.22"
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  # EKS CLUSTER VPC AND SUBNETS
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS MANAGED NODE GROUPS
  eks_managed_node_groups = {
    gitops-demo = {
      desired_size   = 2
      instance_types = ["t3.small"]
    }
  }

  node_security_group_additional_rules = {
    admission_webhook = {
      description                   = "Admission Webhook"
      protocol                      = "tcp"
      from_port                     = 0
      to_port                       = 65535
      type                          = "ingress"
      source_cluster_security_group = true
    }

    ingress_node_communications = {
      description = "Ingress Node to node"
      protocol    = "tcp"
      from_port   = 0
      to_port     = 65535
      type        = "ingress"
      self        = true
    }

    egress_node_communications = {
      description = "Egress Node to node"
      protocol    = "tcp"
      from_port   = 0
      to_port     = 65535
      type        = "egress"
      self        = true
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
