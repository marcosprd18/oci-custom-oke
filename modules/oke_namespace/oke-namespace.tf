resource "kubernetes_namespace" "oke_namespace_ingress_controller" {
  metadata {
    name = "ingress-controller"
  }
}
