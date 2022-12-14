resource "kubernetes_manifest" "main" {
  depends_on = [
    helm_release.external_ingress_nginx,
    helm_release.internal_ingress_wallarm
  ]
  for_each = fileset("../../manifests", "*.yaml")
  manifest = yamldecode(file("../../manifests/${each.value}"))
}
