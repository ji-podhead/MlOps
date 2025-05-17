terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable necessary APIs for MLOps components
resource "google_project_service" "apis" {
  for_each = toset([
    "compute.googleapis.com",
    "storage.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "aiplatform.googleapis.com",
    "dataflow.googleapis.com",
    "cloudresourcemanager.googleapis.com", # Required for enabling other APIs
    "datalineage.googleapis.com",
    "dataplex.googleapis.com", # For Feature Store and Metadata Store
    "notebooks.googleapis.com",
    "dataform.googleapis.com",
    "vision.googleapis.com",
    "container.googleapis.com", # Often needed for Vertex AI Pipelines/Kubeflow
    "cloudfunctions.googleapis.com", # For triggers
    "pubsub.googleapis.com", # For triggers
  ])
  project                    = var.project_id
  service                    = each.key
  disable_on_destroy         = false
  disable_dependent_services = true
}