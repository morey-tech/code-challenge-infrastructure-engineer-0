# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
resource "google_project" "project" {
  name       = var.project_id
  project_id = var.project_id
  org_id     = var.org_id

  billing_account = var.billing_account
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "services" {
  for_each = var.project_services

  project = google_project.project.id
  service = each.key

  timeouts {
    create = "30m"
    update = "40m"
  }

  # an error will be generated if any enabled services depend on this service when destroying it.
  disable_dependent_services = false 
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
    ip_configuration {
    ipv4_enabled = true
    authorized_networks {
        name = "allow_network"
        value = var.database_instance_allowed_network
      }
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database
resource "google_sql_database" "database" {
  name     = var.database_name
  project  = google_project.project.id
  instance = google_sql_database_instance.master.name
}

resource "google_sql_user" "user" {
  name     = var.database_credentials.user
  instance = google_sql_database_instance.master.name
  password = var.database_credentials.password
  depends_on = [
    google_sql_database.database
  ]

  # Use a provisioner to seed the database with a schema from a file. This requires
  # that the host running terraform has `psql` installed.
  # Note: if the schema is deleted but the user exists Terraform will not re-apply the schema.
  # Potential solution, replace the resource:
  #   terraform apply -replace="google_sql_user.user"
  # https://www.terraform.io/cli/commands/plan#replace-address
  provisioner "local-exec" {
    command = "PGPASSWORD=${google_sql_user.user.password} psql -U ${google_sql_user.user.name} -h ${google_sql_database_instance.master.public_ip_address} -f ${var.database_seed_file} ${var.database_name}"
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance#example-usage---redis-instance-basic
resource "google_redis_instance" "cache" {
  name     = var.redis_instance_name
  project  = google_project.project.id
  region   = var.region

  memory_size_gb = var.redis_instance_size
  tier           = var.redis_instance_tier
}