# Provider configuration
provider "aws" {
  region = var.aws_region
}

module "eks" {
  source                  = "./eks"
  eks_node_group_role_arn = module.roles.eks_node_group_role_arn
  eks_iam_role_arn        = module.roles.eks_iam_role_arn
}


module "roles" {
  source = "./roles"
}

module "s3" {
  source = "./s3"
}

