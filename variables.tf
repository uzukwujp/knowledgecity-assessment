
variable "cidr_block" {
    type = string
}

variable "instance_tenancy" {
    type = string 
}

variable "enable_dns_hostnames" {
    type = bool  
}

variable "tag" {
    type = string
}

variable "region" {
 type = string  
}

variable "cluster_name" {
    type = string  
}

variable "cluster_role_name" {
    type = string 
}

variable "az_count" {
    type = number  
}

variable "node_group_name" {
    type = string  
}

variable "instance_types" {
    type = list(string)
}

variable "capacity_type" {
    type = string
}

variable "desired_size" {
    type = number  
}

variable "max_size" {
    type = number
}

variable "max_unavailable" {
    type = number
}

variable "min_size" {
    type = number  
}

variable "worker_node_iam_role_name" {
   type = string  
}

variable "addons" {
  type = list(map(string))
}

variable "karpenter_version" {
    type = string
    description = "karpenter helm chart version"  
}

variable "chart_version" {
    type        = string
    description = "The exact chart version of helm chart"  
}

variable "custom_values" {
    type        = string
    description = "file path to custom helm values file"  
}

variable "cluster_version" {
  type = string  
}

variable "cilium_custom_values" {
    type = string
    description = "variable to pass in the file path of cilium helm values file"  
}

variable "cilium_chart_version" {
  type = string
  description = "helm chart version for cilium"
}

variable "repository_names" {
   type = list(map(string))
   description = "names of private ecr repository names"  
}

variable "prometheus_chart_version" {
    type = string
    description = "kube-prometheus-stack chart version"  
}

variable "prometheus_custom_values" {
    type = string
    description = "file path to custom helm values.yaml file for kube-prometheus-stack"  
}

variable "database_engine" {
  type = string
  description = "The database engine to be used for rds. example 'postgres', 'mysql' etc"
}

variable "environment" {
    type = string
    description = "possible values could be production or development. This controls snapshot backup logic for the database"  
}

variable "database_engine_version" {
    type = string
    description = "The version of the database engine preferred"  
}

variable "db_instance_class" {
    type = string
    description = "The size of the database instance"  
}

variable "db_name" {
    type = string
    description = "database name"  
}

variable "db_password" {
    type = string
    description = "database password"  
}

variable "db_username" {
    type = string
    description = "database username"  
}



