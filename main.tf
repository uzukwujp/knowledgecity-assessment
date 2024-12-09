
module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  az_count             = var.az_count
  tag                  = var.tag
  cluster_name         = var.cluster_name
}

module "ecr" {
  source               = "./modules/ecr"
  for_each             = { for idx, repo_name in var.repository_names : idx => repo_name }
  repository_names     = each.value.repo_name
}

module "rds" {
  source               = "./modules/rds"
  engine               = var.database_engine
  environment          = var.environment
  engine_version       = var.database_engine_version
  db_instance_class    = var.db_instance_class
  db_name              = var.db_name
  db_password          = var.db_password
  db_username          = var.db_username
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  depends_on           = [ module.vpc ]  
}

module "eks" {
  source               =  "./modules/eks/control_plane"
  cluster_version      = var.cluster_version
  cluster_name         = var.cluster_name
  cluster_role_name    = var.cluster_role_name
  private_subnet_ids   = module.vpc.private_subnet_ids
  depends_on           = [ module.vpc ]
}

module "worker_node" {
  source                    =  "./modules/eks/worker_node"
  node_group_name           =  var.node_group_name
  private_subnet_ids        =  module.vpc.private_subnet_ids
  desired_size              =  var.desired_size
  kubernetes_version        =  var.cluster_version
  max_size                  =  var.max_size
  max_unavailable           =  var.max_unavailable
  min_size                  =  var.min_size
  cluster_name              =  var.cluster_name
  capacity_type             =  var.capacity_type
  instance_types            =  var.instance_types
  worker_node_iam_role_name =  var.worker_node_iam_role_name
  depends_on                = [ module.eks]
}

module "eks_addons" {
  source        = "./modules/eks/addons"
  for_each      = { for idx, addon in var.addons : idx => addon }    
  cluster_name  = module.eks.cluster_name
  addon_name    = each.value.addon_name
  addon_version = each.value.addon_version
  depends_on    = [module.worker_node ]
}

module "cilium" {
  source                   = "./modules/cilium"
  cilium_chart_version     = var.cilium_chart_version
  cilium_custom_values     = var.cilium_custom_values
  depends_on               = [module.kube-prometheus-stack]
}

module "karpenter" {
  source                    = "./modules/karpenter"
  cluster_name              = var.cluster_name
  vpc_id                    = module.vpc.vpc_id
  karpenter_version         = var.karpenter_version
  cluster_security_group_id = module.eks.cluster_security_group_id
  depends_on                = [module.worker_node]  
}

module "argocd" {
  source        = "./modules/argocd"
  chart_version = var.chart_version
  custom_values = var.custom_values
  depends_on    = [ module.worker_node ]  
}

module "kube-prometheus-stack" {
  source      = "./modules/kube-prometheus-stack"
  prometheus_chart_version = var.prometheus_chart_version
  prometheus_custom_values = var.prometheus_custom_values
  depends_on               = [module.eks_addons]  
}

