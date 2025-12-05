# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list

# 퍼블릭 서브넷용 시큐리티 리스트
resource "oci_core_security_list" "public" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: VCN ID, 이름, 모든 아웃바운드와 인바운드 트래픽을 허용하는 룰 설정

  egress_security_rules {
    destination      = "<대상>"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    description      = "<설명>"
    stateless        = false
  }

  ingress_security_rules {
    protocol    = "all"
    source      = "<소스>"
    description = "<설명>"
    stateless   = false
  }
}

# 프라이빗 서브넷용 시큐리티 리스트
resource "oci_core_security_list" "private" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  # TODO: VCN ID, 이름, 모든 아웃바운드 트래픽과 VCN 내부에서 발생한 인바운드 트래픽을 허용하는 룰 설정
}
