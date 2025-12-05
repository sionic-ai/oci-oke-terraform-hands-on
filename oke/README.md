# oke

OKE 클러스터와 노드풀을 생성합니다.

## 1. OKE 생성

**참고**
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster>

`oke.tf` 파일에서, OKE 클러스터를 `oci_containerengine_cluster` 리소스를 이용해 생성합니다.
크게 설정할 부분은 없고, 사용해야할 ID들만 잘 채워주면 됩니다.

## 2. 노드풀 생성

**참고**
- <https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool>

`nodepool.tf` 파일에서, OKE 클러스터용 노드풀을 `oci_containerengine_node_pool` 리소스를 이용해 생성합니다.
사용해야할 ID과 값들을 잘 채워주면 되는데, 2가지 개선할 수 있는 지점이 있습니다.

1. 이미지 ID를 자동으로 최신으로 가져올 수 있는 방법이 있을까?
2. SSH 퍼블릭 키를 넣어주고 프라이빗키를 별도로 관리하기 보다는, SSH 키도 테라폼에서 관리할 수 있을까?
    - 힌트: <https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key>
