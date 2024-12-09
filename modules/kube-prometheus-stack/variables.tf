
variable "prometheus_chart_version" {
  type        = string
  description = "The exact helm chart version of argocd"  
}

variable "prometheus_custom_values" {
  type        = string
  description = "path to the custom helm values file"
  default     = ""  
}