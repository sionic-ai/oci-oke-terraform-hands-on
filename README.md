# sionic-terraform-labs - OCI OKE Stack (Quickstart)

## 준비물

- [Terraform](https://developer.hashicorp.com/terraform/install)
- OCI 인증키 (`~/.oci/config` 파일에 인증 정보가 있어야함)
  - [oci-cli](https://github.com/oracle/oci-cli)를 설치하고, `oci session authenticate` 명령어를 통해 발급 가능
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## 마일스톤

### 1. Terraform 기본 및 OCI provider 세팅

1. 테라폼 설치 확인
    ```
    terraform -v
    ```
2. OCI 인증키 확인
    ```
    oci iam compartment list
    ```
    - 위 커맨드로 compartment 목록을 확인할 수 있는지 체크
3. `compartment` 디렉토리에서 `oci_identity_compartment` 테라폼 데이터소스를 통해 본인의 compartment를 가져오기
    - 추후 모든 리소스에서 이 compartment의 ID를 이용

### 2. VCN 및 서브넷 생성

`network` 디렉토리 참고

### 2. OKE 클러스터 및 노드풀 생성

`oke` 디렉토리 참고

### 4. Kubernetes 접근 및 샘플 앱 배포

1. Kubernetes를 `kubectl`을 통해 접근
    - `oci_containerengine_cluster_kube_config` 데이터 소스에서 생성된 kubeconfig을 이용해도 되고
    - oci-cli를 이용해 `oci ce cluster create-kubeconfig --cluster-id <id> --file kubeconfig --region ap-seoul-1 --token-version 2.0.0 --kube-endpoint PUBLIC_ENDPOINT` 커맨드를 쳐서 생성해도 된다
    - 이후 이 kubeconfig을 `~/.kube/config` 에 넣어주거나 (기존 파일이 덮어씌워지지 않게 조심), `kubectl --kubeconfig <경로> 어쩌구` 를 통해 접근해보자
2. 샘플 앱 배포
    - `busybox` 디렉토리 참고
