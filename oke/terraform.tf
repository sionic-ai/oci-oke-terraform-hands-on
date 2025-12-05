terraform {
  backend "local" {
    path = "oke.tfstate"
  }
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  region = "ap-seoul-1"
}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/network.tfstate"
  }
}

data "terraform_remote_state" "compartment" {
  backend = "local"
  config = {
    path = "../compartment/compartment.tfstate"
  }
}

data "oci_identity_availability_domains" "this" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
}
