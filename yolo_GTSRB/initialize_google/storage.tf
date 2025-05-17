resource "google_storage_bucket" "mlops_bucket" {
  name          = "${var.project_id}-mlops-bucket"
  location      = var.region
  force_destroy = false # Set to true with caution, deletes all objects in the bucket when destroying the resource
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365 # Delete objects older than 365 days
    }
  }

  depends_on = [google_project_service.apis]
}