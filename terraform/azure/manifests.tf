resource "kubectl_manifest" "main" {
  depends_on = [
    azurerm_kubernetes_cluster.aks,
    helm_release.external_ingress_nginx,
    helm_release.internal_ingress_wallarm
  ]
  for_each = fileset("../../manifests", "*.yaml")
  yaml_body = file("../../manifests/${each.value}")
}
