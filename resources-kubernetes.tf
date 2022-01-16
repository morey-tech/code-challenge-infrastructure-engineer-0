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

# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler
resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
  metadata {
    name = "${var.deployment_name}-hpa"
  }

  spec {
    max_replicas = var.deployment_hpa_max_replicas
    # default the minimum to the deployment replicas.
    min_replicas = var.deployment_hpa_min_replicas != null ? var.deployment_hpa_min_replicas : var.deployment_replicas

    target_cpu_utilization_percentage = var.deployment_hpa_target_cpu_percent

    scale_target_ref {
      kind = "Deployment"
      name = var.deployment_name
    }
  }
}