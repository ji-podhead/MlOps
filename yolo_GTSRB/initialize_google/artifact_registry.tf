resource "google_artifact_registry_repository" "mlops_repo" {
  location      = var.region
  repository_id = "${var.project_id}-mlops-repo"
  description   = "Docker repository for MLOps pipeline components"
  format        = "DOCKER"

  depends_on = [google_project_service.apis]
}