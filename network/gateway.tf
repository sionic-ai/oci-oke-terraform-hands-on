# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway
resource "oci_core_internet_gateway" "this" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: 이름과 VCN ID를 설정하기
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway
resource "oci_core_nat_gateway" "this" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: 이름과 VCN ID를 설정하기
}
