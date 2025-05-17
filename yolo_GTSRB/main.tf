# This is the root module that calls the initialize_google module

module "google_infrastructure" {
  source = "./initialize_google"

  project_id = var.project_id
  region     = var.region
}

# You can define outputs here to expose values from the module
# output "bucket_name" {
#   description = "Name of the created GCS bucket"
#   value       = module.google_infrastructure.mlops_bucket_name
# }

# output "artifact_registry_repo_id" {
#   description = "ID of the created Artifact Registry repository"
#   value       = module.google_infrastructure.artifact_registry_repo_id
# }

# output "artifact_registry_repo_location" {
#   description = "Location of the created Artifact Registry repository"
#   value       = module.google_infrastructure.artifact_registry_repo_location
# }

# output "vertex_ai_dataset_id" {
#   description = "ID of the created Vertex AI Dataset"
#   value       = module.google_infrastructure.vertex_ai_dataset_id
# }