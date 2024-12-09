
addons = [{
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.2-eksbuild.2"
  },

  {
    addon_name    = "aws-ebs-csi-driver"
    addon_version = "v1.36.0-eksbuild.1"
  }
]

repository_names   = [ 
  {
  "repo_name"      = "knowledgecity"
  } 
]

cidr_block                 = "10.0.0.0/16"
instance_tenancy           = "default"
enable_dns_hostnames       = "true"
tag                        = "testing"
region                     = "us-east-1"
cluster_name               = "poc-cluster"
cluster_role_name          = "poc-cluster-IAM-role"
az_count                   = 2
node_group_name            = "poc-worker-nodes"
instance_types             = ["t3.medium"]
capacity_type              = "ON_DEMAND"
desired_size               = 2
max_size                   = 2
max_unavailable            = 1
min_size                   = 1
worker_node_iam_role_name  = "poc-worker-node-IAM-role"
karpenter_version          = "1.0.0"
chart_version              = "7.7.1"
custom_values              = "helm-values/argocd_values.yaml"
cluster_version            = "1.31"
cilium_chart_version       = "1.16.4"
cilium_custom_values       = "helm-values/cilium_values.yaml"
prometheus_chart_version   = "66.3.1"
prometheus_custom_values   = "helm-values/prometheus_custom_values.yaml"
database_engine            = "mysql"
environment                = "production"
database_engine_version    = "8.0"
db_instance_class          = "db.t3.micro"
db_name                    = "knowledgecity"
db_password                = "johnpaulz"
db_username                = "johnpaulz"
schemahero_chart_version   = "1.3.4"
schemahero_custom_values   = "helm-values/schemahero_values.yaml"



