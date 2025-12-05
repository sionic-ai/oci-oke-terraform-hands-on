# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway
resource "oci_core_internet_gateway" "this" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  display_name   = "internet-gateway"
  enabled        = true
  vcn_id         = oci_core_vcn.this.id
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway
resource "oci_core_nat_gateway" "this" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  display_name   = "nat-gateway"
  vcn_id         = oci_core_vcn.this.id
}
