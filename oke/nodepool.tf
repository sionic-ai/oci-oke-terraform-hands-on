# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool

resource "oci_containerengine_node_pool" "default" {
  compartment_id     = "<컴파트먼트 ID>"
  cluster_id         = "<클러스터 ID>"
  name               = "<이름>"
  kubernetes_version = "v1.31.1"
  node_shape         = "VM.Standard.E4.Flex"

  node_shape_config {
    memory_in_gbs = 8
    ocpus         = 2
  }

  node_source_details {
    source_type             = "IMAGE"
    image_id                = "<이미지 ID>" # 이미지 ID를 최신으로 자동으로 가져오고 싶으면 어떻게 할까?
    boot_volume_size_in_gbs = 100
  }

  ssh_public_key = "<SSH 퍼블릭 키>" # SSH 퍼블릭/프라이빗 키도 테라폼에서 관리하고 싶으면 어떻게 할까?

  node_config_details {
    size = 1

    placement_configs {
      subnet_id           = "<프라이빗 서브넷 ID>"
      availability_domain = data.oci_identity_availability_domains.this.availability_domains[0].name
    }

    node_pool_pod_network_option_details {
      max_pods_per_node = 31
      cni_type          = "OCI_VCN_IP_NATIVE"
      pod_subnet_ids    = ["<프라이빗 서브넷 ID>"]
    }
  }
}
