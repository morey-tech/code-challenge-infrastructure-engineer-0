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

# kubernetes
variable "deployment_name" {
  type        = string
  default     = "nginx"
  description = "Name of the kubernetes deployment."
}

variable deployment_replicas {
  type        = number
  default     = 2
  description = "The number of replicas for the deployment."
}

variable deployment_image {
  type        = string
  default     = "nginx:1.20.2"
  description = "The image for the main container of the deployment."
}

variable deployment_port {
  type        = string  # use string instead of number since we won't be doing math on it.
  default     = "80"
  description = "The port to expose on the main container of the deployment."
}

# Depending on the use case, these 4 variables for the container request quotas
# could make more sense as an object/map variable.
variable deployment_cpu_limit {
  type        = string
  default     = "500m"
  description = "The CPU limit on the main container of the deployment."
}

variable deployment_mem_limit {
  type        = string
  default     = "512Mi"
  description = "The memory limit on the main container of the deployment."
}

variable deployment_cpu_requests {
  type        = string
  default     = "250m"
  description = "The CPU requests on the main container of the deployment."
}

variable deployment_mem_requests {
  type        = string
  default     = "50Mi"
  description = "The memory requets on the main container of the deployment."
}