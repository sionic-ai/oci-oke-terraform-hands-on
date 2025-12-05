# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet

# 퍼블릭 서브넷
resource "oci_core_subnet" "public" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: VCN ID, 이름, CIDR, Route Table ID, Security List ID를 설정
}

# 프라이빗 서브넷
resource "oci_core_subnet" "private" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: VCN ID, 이름, CIDR, Route Table ID, Security List ID, 퍼블릭 IP 할당 비활성화를 설정
}
