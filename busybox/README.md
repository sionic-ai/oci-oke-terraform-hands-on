# busybox

busybox 샘플 앱을 Kubernetes에 배포하는 것을 테라폼으로 해봅시다.

## provider 설정

`terraform.tf` 파일을 보면,

```hcl
data "oci_containerengine_cluster" "oke_cluster" {
  cluster_id = data.terraform_remote_state.oke.outputs.oke_cluster_id
}

provider "kubernetes" {
  host                   = "https://${data.oci_containerengine_cluster.oke_cluster.endpoints[0].public_endpoint}"
  cluster_ca_certificate = base64decode(data.terraform_remote_state.oke.outputs.oke_cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "oci"
    args = [
      "ce",
      "cluster",
      "generate-token",
      "--cluster-id",
      data.terraform_remote_state.oke.outputs.oke_cluster_id,
      "--region",
      "ap-seoul-1",
    ]
  }
}
```

을 통해 kubernetes 프로바이더를 동적으로 설정하는 것을 볼 수 있습니다.

## 샘플 앱 배포

`main.tf` 파일에서 `kubernetes_deployment`, `kubernetes_service` 리소스를 이용해 샘플 앱을 배포합니다.
