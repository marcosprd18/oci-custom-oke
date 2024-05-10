terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    local = {
      source = "hashicorp/local"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}