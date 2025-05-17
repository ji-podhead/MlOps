output "mlops_bucket_name" {
  description = "Name of the MLOps Cloud Storage bucket"
  value       = google_storage_bucket.mlops_bucket.name
}

output "artifact_registry_repo_id" {
  description = "ID of the Artifact Registry repository"
  value       = google_artifact_registry_repository.mlops_repo.repository_id
}

output "artifact_registry_repo_location" {
  description = "Location of the Artifact Registry repository"
  value       = google_artifact_registry_repository.mlops_repo.location
}

output "vertex_ai_dataset_id" {
  description = "ID of the created Vertex AI Dataset"
  value       = google_vertex_ai_dataset.gtsrb_classification_dataset.id
}