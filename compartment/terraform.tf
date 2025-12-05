terraform {
  backend "local" {
    path = "compartment.tfstate"
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
