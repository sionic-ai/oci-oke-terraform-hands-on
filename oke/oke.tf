# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster

resource "oci_containerengine_cluster" "this" {
  compartment_id     = data.terraform_remote_state.compartment.outputs.compartment_ocid
  name               = "sionic-terraform-labs-oke"
  kubernetes_version = "v1.31.1"
  vcn_id             = data.terraform_remote_state.network.outputs.vcn_id
  type               = "ENHANCED_CLUSTER"

  options {
    service_lb_subnet_ids = [data.terraform_remote_state.network.outputs.public_subnet_id]
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
  }

  cluster_pod_network_options {
    cni_type = "OCI_VCN_IP_NATIVE"
  }

  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = data.terraform_remote_state.network.outputs.public_subnet_id
  }
}

# Kubeconfig에서 CA 인증서를 추출
data "oci_containerengine_cluster_kube_config" "this" {
  cluster_id = oci_containerengine_cluster.this.id
  endpoint   = "PUBLIC_ENDPOINT"
}
locals {
  kubeconfig_ca_cert = yamldecode(data.oci_containerengine_cluster_kube_config.this.content).clusters[0].cluster["certificate-authority-data"]
}
