
resource "helm_release" "cilium" {
  name             = "cilium"
  repository       = "https://helm.cilium.io"
  chart            = "cilium"
  version          = var.cilium_chart_version
  namespace        = "kube-system"
  create_namespace = true
  values           = var.cilium_custom_values != "" ? [file("${path.root}/${var.cilium_custom_values}")] : []  
}