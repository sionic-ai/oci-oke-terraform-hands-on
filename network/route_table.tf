# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table

# 퍼블릭 서브넷용 라우트 테이블
resource "oci_core_route_table" "public" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "public"

  route_rules {
    network_entity_id = oci_core_internet_gateway.this.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    description       = "To Internet"
  }
}

# 프라이빗 서브넷용 라우트 테이블
resource "oci_core_route_table" "private" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "private"

  route_rules {
    network_entity_id = oci_core_nat_gateway.this.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    description       = "To NAT"
  }
}
