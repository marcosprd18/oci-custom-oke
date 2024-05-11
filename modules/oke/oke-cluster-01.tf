resource "oci_containerengine_cluster" "oke_cluster_01" {
  compartment_id     = var.compartment_id
  kubernetes_version = "v1.29.1" ## Versão do K8s. Recomendado utilizar a última versão disponível.
  name               = "oke-cluster-01"
  vcn_id             = var.vcn_nprod_id ## ID da VCN que será utilizada. 

  cluster_pod_network_options {  ## Tipo de rede a ser utilizada. 
    cni_type = "FLANNEL_OVERLAY" # Com FLANNEL_OVERLAY, os ranges do pod e services não são roteados para dentro da VPN. É o CNI padráo e mais recomendado para evitar overlapping, devido ao tamanho do range necessário para os pods e services.
    # cni_type = "OCI_VCN_IP_NATIVE" #OCI_VCN_IP_NATIVE permite rotear o range dos pods e services dentro da VCN.
  }

  endpoint_config {
    is_public_ip_enabled = false                 ## Se configurado como True, o seu endpoint de gerenciamento do Cluster recebe um IP público.
    subnet_id            = var.subnet_api_private_id ## ID da subnet que será utilizada. Recomendado o uso de subnet privada para ambientes de produção.
  }

  ## Tags para o cluster.
  freeform_tags = {
    "app"  = "myapp"
    "area" = "cloud"
  }

  options {

    add_ons {
      is_kubernetes_dashboard_enabled = false ## Possibilita a criação de um web based k8s interface.
      is_tiller_enabled               = false ## Mantém o tiller desabilitado. Descontinuado do helm.
    }

    ## Tags que serão adicionadas aos LBs
    service_lb_config {
      freeform_tags = {
        "app"  = "myapp"
        "area" = "cloud"
      }
    }

    kubernetes_network_config {
      pods_cidr     = "172.28.0.0/16" ## Range de IP reservado para pods.
      services_cidr = "172.29.0.0/16" ## Range de IP reservado para services.
    }

    service_lb_subnet_ids = [var.subnet_lb_public_id] ## ID da subnet que será utilizada. Pode ser informado mais de uma subnet, publica ou privada. 
  }
}

