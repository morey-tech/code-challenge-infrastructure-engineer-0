# Infrastructure Engineer Code Challenge

Using Bash, Kubectl and Terraform; create the following configuration.

Please use variables so we can quickly create many different environments.

1. GKE Autopilot Cluster
  - Nginx deployment
     - Autoscale on cpu (50%)
2. Cloud SQL MySQL 8 Instance
  - Machine Type: standard
  - Seed with the table db.user
    - id
    - first_name
    - last_name
    - email
3. Cloud Memorystore Redis Instance
  - Capacity: 1GB

## Prerequisites
### CLI Tools:
```
$ terraform -version
Terraform v1.1.2
$ gcloud version
Google Cloud SDK 330.0.0
```
### Provider Auth
```
$ gcloud auth application-default login
$ ln -s /home/$USER/.config/gcloud/application_default_credentials.json credentials.json
```