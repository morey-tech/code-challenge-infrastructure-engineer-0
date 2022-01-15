terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.6.0"
    }
  }

  # lock tf to v1.1.x
  required_version = ">= 1.1"
}