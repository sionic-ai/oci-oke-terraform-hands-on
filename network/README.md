# network

VCN, Subnet 등의 기초적인 OCI 네트워크를 생성합니다.

## 1. VCN 생성

**참고**
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn>

`vcn.tf` 파일에서, `oci_core_vcn` 리소스를 활용해 VCN을 생성합니다.
CIDR 대역은 `10.0.0.0` 하위에서 `16` 정도의 크기가 적절할 것 같습니다.

## 2. gateway 생성

**참고**
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway>
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway>

`gateway.tf` 파일에서, 외부 인터넷과의 통신을 위해 Internet Gateway와 NAT Gateway를 각각 `oci_core_internet_gateway`와 `oci_core_nat_gateway` 리소스를 이용해 생성합니다.
특별히 설정해야할 옵션은 없고, 이름과 연결할 VCN ID를 설정하면 됩니다.

## 3. 라우트 테이블 생성

**참고**
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table>

`route_table.tf` 파일에서, 퍼블릭 서브넷과 프라이빗 서브넷을 위한 라우트 테이블을 `oci_core_route_table` 리소스를 이용해 생성합니다.
퍼블릭 서브넷 라우트 테이블은 기본 (`0.0.0.0/0`) 경로를 Internet Gateway로, 프라이빗 서브넷 라우트 테이블을 기본 경로를 NAT Gateway로 잡아주어야 합니다.

## 4. 시큐리티 리스트 생성

**참고**
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list>

`security_list.tf` 파일에서, 퍼블릭 서브넷과 프라이빗 서브넷을 위한 시큐리티 리스트를 `oci_core_security_list` 리소스를 이용해 생성합니다.
퍼블릭 서브넷 시큐리티 리스트는 모든 아웃바운드 트래픽과 인바운드 트래픽을 허용하고, 프라이빗 서브넷 시큐리티 리스트는 모든 아웃바운드 트래픽은 허용하되, 인바운드 트래픽은 VCN 내부에서 발생한 트래픽만을 허용하게 설정해봅시다.

## 5. 서브넷 생성

**참고**
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet>

`subnet.tf` 파일에서, 퍼블릭 서브넷과 프라이빗 서브넷을 `oci_core_subnet` 리소스를 이용해 생성합니다.
각 서브넷의 CIDR을 `17` 크기 정도로 잡고, 위 단계에서 생성한 Route Table, Security List를 설정해줍니다.
프라이빗 서브넷은 퍼블릭 IP를 할당하지 않도록 해줘야합니다.
