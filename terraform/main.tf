module "vpc" {
  source = "./modules/vpc"

  name               = "${var.project}-${var.environment}"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  single_nat_gateway = var.single_nat_gateway
}

module "iam" {
  source = "./modules/iam"

  name = "${var.project}-${var.environment}"
}

module "ecr" {
  source = "./modules/ecr"

  repository_names = var.ecr_repository_names
}

module "eks" {
  source = "./modules/eks"

  depends_on = [module.iam]

  name               = "${var.project}-${var.environment}"
  kubernetes_version = var.cluster_kubernetes_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn

  endpoint_private_access = true
  endpoint_public_access  = var.cluster_endpoint_public
  public_access_cidrs     = var.cluster_endpoint_public_cidrs

  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
}