resource "oci_containerengine_node_pool" "oke_node_pool_01" {
  cluster_id         = oci_containerengine_cluster.oke_cluster_01.id ## Datasource com o ID do cluster.
  compartment_id     = var.compartment_id
  name               = "oke-node-pool-01"
  node_shape         = var.node_shape ## Shape do node. Exemplo: VM.Standard.E4.Flex
  kubernetes_version = "v1.29.1"

  ## Tags para o node pool.
  freeform_tags = {
    "app"  = "myapp"
    "area" = "cloud"
  }

  ## Labels que são atribuídas ao nó.

  initial_node_labels {
    key   = "name"
    value = "oke-node-pool-01"
  }

  initial_node_labels {
    key   = "environment"
    value = "prod"
  }

  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name ## Datasource com o ID do AD disponível no tenancy e região. 
      subnet_id           = var.subnet_private_id ## ID da subnet que será utilizada. Recomendado o uso de subnet privada.
    }
    size = 1 ## Quantidade de nós no node pool.
  }

  node_shape_config {
    memory_in_gbs = 4 ## Quantidade de memória para cada node 
    ocpus         = 1 ## Quantidade de OCPU para cada node. 1 OCPU equivale a 2 vCPU 
  }

  node_source_details {
    image_id                = var.oke_oracle_linux_8 ## ID da imagem a ser usada no nó. Neste caso, utilizado o Oracle Linux 8. Os IDs podem ser encontrados no portal da Oracle Cloud.
    source_type             = "image"                ## Tipo de imagem a ser utilizada. Neste caso, é uma imagem da OCI.
    boot_volume_size_in_gbs = 90                     ## Tamanho do disco a ser alocado na VM. Por padrão a OCI utiliza 50GB. Os outros 50GB devem ser expandidos de forma manual ou no startup scrip.
  }

  node_metadata = {
    ssh_authorized_keys = file("${path.module}/ssh-public-key.pub") ## Chave que será enviada para o nó. Necessário para suportes futuros.
    user_data           = base64encode(file("${path.module}/bootstrap"))
  }
}