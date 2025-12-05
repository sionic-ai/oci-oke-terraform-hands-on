resource "kubernetes_deployment" "busybox" {
  metadata {
    name      = "busybox-app"
    namespace = "default"
    labels = {
      app = "busybox-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "busybox-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "busybox-app"
        }
      }

      spec {
        container {
          name  = "busybox"
          image = "busybox:1.36"
          command = [
            "sh",
            "-c",
            "mkdir -p /www && echo 'hello from busybox' > /www/index.html && httpd -f -p 80 -h /www"
          ]
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "busybox" {
  metadata {
    name      = "busybox-service"
    namespace = "default"
    labels = {
      app = "busybox-app"
    }
  }

  spec {
    selector = {
      app = "busybox-app"
    }
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    type = "LoadBalancer"
  }
}
