resource "kubernetes_deployment" "testpod" {
  metadata {
    name = "testpod"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "testpod"
      }
    }

    template {
      metadata {
        labels = {
          app = "testpod"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.pod_sa.metadata[0].name

        container {
          image = "nginx:latest"
          name  = "testpod"
        }
      }
    }
  }
}
