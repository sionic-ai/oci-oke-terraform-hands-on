# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster

resource "oci_containerengine_cluster" "this" {
  compartment_id     = "<컴파트먼트 ID>"
  name               = "<이름>"
  kubernetes_version = "v1.31.1"
  vcn_id             = "<VCN ID>"
  type               = "ENHANCED_CLUSTER"

  options {
    service_lb_subnet_ids = ["<퍼블릭 서브넷 ID>"]
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
  }

  cluster_pod_network_options {
    cni_type = "OCI_VCN_IP_NATIVE"
  }

  endpoint_config {
    is_public_ip_enabled = true # 이번 실습은 public endpoint를 통해 진행
    subnet_id            = "<퍼블릭 서브넷 ID>"
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
