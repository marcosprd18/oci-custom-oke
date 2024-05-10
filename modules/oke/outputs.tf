output "oke_cluster" {
  value = {
    id                 = oci_containerengine_cluster.oke_cluster_01.id
    kubernetes_version = oci_containerengine_cluster.oke_cluster_01.kubernetes_version
    name               = oci_containerengine_cluster.oke_cluster_01.name
    endpoint_config    = oci_containerengine_cluster.oke_cluster_01.endpoint_config
    endpoint           = oci_containerengine_cluster.oke_cluster_01.endpoints
  }
}