# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn
resource "oci_core_vcn" "this" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: CIDR을 설정하기
}
