# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet

# 퍼블릭 서브넷
resource "oci_core_subnet" "public" {
  compartment_id             = data.terraform_remote_state.compartment.outputs.compartment_ocid
  vcn_id                     = oci_core_vcn.this.id
  cidr_block                 = "10.0.0.0/17"
  display_name               = "public-subnet"
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.public.id
  security_list_ids          = [oci_core_security_list.public.id]
  dns_label                  = "pub"
}

# 프라이빗 서브넷
resource "oci_core_subnet" "private" {
  compartment_id             = data.terraform_remote_state.compartment.outputs.compartment_ocid
  vcn_id                     = oci_core_vcn.this.id
  cidr_block                 = "10.0.128.0/17"
  display_name               = "private-subnet"
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.private.id
  security_list_ids          = [oci_core_security_list.private.id]
  dns_label                  = "priv"
}
