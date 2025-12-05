terraform {
  backend "local" {
    path = "busybox.tfstate"
  }
  required_providers {
    oci = {
      source = "oracle/oci"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

data "terraform_remote_state" "oke" {
  backend = "local"
  config = {
    path = "../oke/oke.tfstate"
  }
}

data "oci_containerengine_cluster" "oke_cluster" {
  cluster_id = data.terraform_remote_state.oke.outputs.oke_cluster_id
}

provider "kubernetes" {
  host                   = "https://${data.oci_containerengine_cluster.oke_cluster.endpoints[0].public_endpoint}"
  cluster_ca_certificate = base64decode(data.terraform_remote_state.oke.outputs.oke_cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "oci"
    args = [
      "ce",
      "cluster",
      "generate-token",
      "--cluster-id",
      data.terraform_remote_state.oke.outputs.oke_cluster_id,
      "--region",
      "ap-seoul-1",
    ]
  }
}
