# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list

# 퍼블릭 서브넷용 시큐리티 리스트
resource "oci_core_security_list" "public" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "public"

  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    description      = "Allow all egress"
    stateless        = false
  }

  ingress_security_rules {
    protocol    = "all"
    source      = "0.0.0.0/0"
    description = "Allow all ingress"
    stateless   = false
  }
}

# 프라이빗 서브넷용 시큐리티 리스트
resource "oci_core_security_list" "private" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "private"

  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    description      = "Allow all egress"
    stateless        = false
  }

  ingress_security_rules {
    protocol    = "all"
    source      = "10.0.0.0/16"
    description = "Allow all from VCN"
    stateless   = false
  }
}
