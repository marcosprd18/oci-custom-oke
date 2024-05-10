########################################################################
### OCI Provider
########################################################################

provider "oci" {
  auth                = "SecurityToken"
  config_file_profile = "DEFAULT"
  region              = var.region_sa
}

module "oke" {
  source = "./modules/oke"
}

module "oke_genconfig" {
  source     = "./modules/oke_genconfig"
  depends_on = [module.oke]
}

########################################################################
### K8S Provider
########################################################################

provider "kubernetes" {
  config_path = "./.kube/config" ## Default location: ~/.kube/config
}

module "oke_namespace" {
  source     = "./modules/oke_namespace"
  depends_on = [module.oke_genconfig]
}

########################################################################
### HELM Provider
########################################################################

provider "helm" {
  debug = true

  kubernetes {
    config_path = "./.kube/config" ## Default location: ~/.kube/config
  }
}

module "oke_ingress_controller" {
  source     = "./modules/oke_ingress_controller"
  depends_on = [module.oke_namespace]
}