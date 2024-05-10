resource "helm_release" "internal_ingress_controller" {
  name       = "int-ingress-controller"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  values     = [ file("${path.module}/internal-ingress-controller.yaml") ]
  namespace  = data.terraform_remote_state.data_tf_state.outputs.oke_namespace_ingress_controller
}

resource "helm_release" "external_ingress_controller" {
  name       = "ext-ingress-controller"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  values     = [ file("${path.module}/external-ingress-controller.yaml") ]
  namespace = data.terraform_remote_state.data_tf_state.outputs.oke_namespace_ingress_controller
}