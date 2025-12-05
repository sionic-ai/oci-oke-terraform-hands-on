# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table

# 퍼블릭 서브넷용 라우트 테이블
resource "oci_core_route_table" "public" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: 이름과 VCN ID, 그리고 Internet Gateway로 가는 경로 설정

  route_rules {
    network_entity_id = "<ID>"
    destination       = "<대상 CIDR>"
    destination_type  = "CIDR_BLOCK"
    description       = "<설명>"
  }
}

# 프라이빗 서브넷용 라우트 테이블
resource "oci_core_route_table" "private" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: 이름과 VCN ID, 그리고 NAT Gateway로 가는 경로 설정
}
