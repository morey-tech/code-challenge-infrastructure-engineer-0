terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      # https://github.com/hashicorp/terraform-provider-google/issues/10782
      # Due to this issue, in order to use autopilot on the google_container_cluster
      # the google provider version must be `4.3.0`.
      version = "4.3.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.1"
    }
  }

  # lock tf to v1.1.x
  required_version = ">= 1.1"
}