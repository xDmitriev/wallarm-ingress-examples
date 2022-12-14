resource "helm_release" "external_ingress_nginx" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  name       = "external-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  version    = "4.4.0"
  values     = [file("../../helm-values/external-ingress-values.yaml")]

  create_namespace = true
}

resource "helm_release" "internal_ingress_wallarm" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  name       = "internal-ingress"
  repository = "https://charts.wallarm.com"
  chart      = "wallarm-ingress"
  namespace  = "wallarm-ingress"
  version    = "4.4.0"
  values     = [file("../../helm-values/internal-ingress-values.yaml")]

  create_namespace = true
}