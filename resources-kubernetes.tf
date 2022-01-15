resource "kubernetes_deployment" "deployment" {
  metadata {
    name = var.deployment_name
    labels = {
      App = var.deployment_name
    }
  }

  spec {
    replicas = var.deployment_replicas
    selector {
      match_labels = {
        App = var.deployment_name
      }
    }
    template {
      metadata {
        labels = {
          App = var.deployment_name
        }
      }
      spec {
        container {
          image = var.deployment_image
          name  = var.deployment_name

          port {
            container_port = var.deployment_port
          }

          resources {
            limits = {
              cpu    = var.deployment_cpu_limit
              memory = var.deployment_mem_limit
            }
            requests = {
              cpu    = var.deployment_cpu_requests
              memory = var.deployment_mem_requests
            }
          }
        }
      }
    }
  }
}
