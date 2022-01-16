# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
resource "google_project" "project" {
  name       = var.project_id
  project_id = var.project_id
  org_id     = var.org_id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project  = google_project.project.id
  location = var.region

  enable_autopilot = true
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
resource "google_sql_database_instance" "master" {
  name             = var.database_instance_name
  database_version = var.database_instance_version
  project          = google_project.project.id
  region           = var.region

  settings {
    tier = var.database_instance_tier
  }
}