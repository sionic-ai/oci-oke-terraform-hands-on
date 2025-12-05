output "oke_cluster_id" {
  value = oci_containerengine_cluster.this.id
}

output "oke_cluster_ca_certificate" {
  value = local.kubeconfig_ca_cert
}
