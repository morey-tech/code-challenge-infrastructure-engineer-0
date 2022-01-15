# google
variable "org_id" {
  description = "The organization ID to create projects in."
}

variable "project_id" {
  description = "The project ID to host the cluster in."
}

variable "region" {
  description = "The region to host the cluster in."
}

variable "cluster_name" {
  description = "The name of the cluster to create."
}