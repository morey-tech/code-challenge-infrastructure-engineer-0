# Infrastructure Engineer Code Challenge

Using Bash, Kubectl and Terraform; create the following configuration.

Please use variables so we can quickly create many different environments.

- [x] GKE Autopilot Cluster
- [x] Nginx deployment
- [x] HPA for Nginx deployment to autoscale on cpu (50%)
- [x] Cloud SQL MySQL 8 Instance
  - Machine Type: standard
- [x] Cloud SQL database
- [x] Seed database with the table `db.user`
  - id
  - first_name
  - last_name
  - email
- [x] Cloud Memorystore Redis Instance
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

### Possible Improvments
- All the region and project vars for the different GCP resources should have the option to override based on a variable but default to the global `project` and `region` vars. For example:
  ```
  region = var.redis_instance_region != null ? var.redis_instance_region : var.region
  ```
- Split the different atomic units/resources into their own modules to make them more usable. For example, a k8s module, a database module, a cache module.
- Use some of the modules provided by Google to better implement best practices as set out by them.
- Add validation to the varaibles to ensure they are in the correct format.
- A remote state to backend.