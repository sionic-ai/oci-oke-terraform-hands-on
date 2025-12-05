# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn
resource "oci_core_vcn" "this" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "sionic-terraform-labs"
  dns_label      = "sioniclabs"
}
