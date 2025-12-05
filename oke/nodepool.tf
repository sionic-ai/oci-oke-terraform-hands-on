# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool

resource "tls_private_key" "default_node_pool_ssh_key" {
  algorithm = "ED25519"
}

data "oci_containerengine_node_pool_option" "oke" {
  node_pool_option_id = "all"
  compartment_id      = data.terraform_remote_state.compartment.outputs.compartment_ocid
}

locals {
  images = reverse(sort([
    for source in data.oci_containerengine_node_pool_option.oke.sources : source.image_id
    if length(regexall("^Oracle-Linux-[\\d.]+-2025\\.\\d{2}\\.\\d{2}-\\d+-OKE-1\\.31\\.1-\\d+$", source.source_name)) > 0
  ]))
}

resource "oci_containerengine_node_pool" "default" {
  compartment_id     = data.terraform_remote_state.compartment.outputs.compartment_ocid
  cluster_id         = oci_containerengine_cluster.this.id
  name               = "default-node-pool"
  kubernetes_version = "v1.31.1"
  node_shape         = "VM.Standard.E4.Flex"

  node_shape_config {
    memory_in_gbs = 8
    ocpus         = 2
  }

  node_source_details {
    source_type             = "IMAGE"
    image_id                = local.images[0]
    boot_volume_size_in_gbs = 100
  }

  ssh_public_key = tls_private_key.default_node_pool_ssh_key.public_key_openssh

  node_config_details {
    size = 1

    placement_configs {
      subnet_id           = data.terraform_remote_state.network.outputs.private_subnet_id
      availability_domain = data.oci_identity_availability_domains.this.availability_domains[0].name
    }

    node_pool_pod_network_option_details {
      max_pods_per_node = 31
      cni_type          = "OCI_VCN_IP_NATIVE"
      pod_subnet_ids    = [data.terraform_remote_state.network.outputs.private_subnet_id]
    }
  }
}
