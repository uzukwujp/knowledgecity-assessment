
resource "helm_release" "cilium" {
  name             = "cilium"
  repository       = "https://helm.cilium.io"
  chart            = "cilium"
  version          = var.schemahero_chart_version
  namespace        = "kube-system"
  create_namespace = true
  values           = var.schemahero_custom_values != "" ? [file("${path.root}/${var.schemahero_custom_values}")] : []  
}