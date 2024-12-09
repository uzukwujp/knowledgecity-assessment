
resource "helm_release" "kube-prometheus-stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = var.prometheus_chart_version
  namespace        = "monitoring"
  create_namespace = true
  values           = var.prometheus_custom_values != "" ? [file("${path.root}/${var.prometheus_custom_values}")] : []  
}