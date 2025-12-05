terraform {
  backend "local" {
    path = "network.tfstate"
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

data "terraform_remote_state" "compartment" {
  backend = "local"
  config = {
    path = "../compartment/compartment.tfstate"
  }
}
