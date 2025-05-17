# Vertex AI Resources

# Vertex AI Dataset for Image Classification
resource "google_vertex_ai_dataset" "gtsrb_classification_dataset" {
  display_name = "gtsrb-traffic-sign-classification"
  metadata_schema_uri = "gs://google-cloud-aiplatform/schema/dataset/metadata/image_1.0.0.yaml"
  region       = var.region
  project      = var.project_id

  labels = {
    task = "classification"
    dataset = "gtsrb"
  }

  # Import data from Cloud Storage
  # Note: The actual data import happens after the dataset resource is created.
  # This block defines the source location for future import operations.
  # You would typically use the gcloud CLI or Vertex AI SDK to perform the import
  # after the dataset resource is provisioned by Terraform.
  depends_on = [
    google_project_service.apis,
    google_storage_bucket.mlops_bucket,
  ]
}


# Vertex AI Feature Store (using Dataplex Lake as a conceptual Feature Store)
# Note: A dedicated Vertex AI Feature Store resource might be more appropriate
# depending on your specific needs and data structure. Dataplex is used here
# as it was mentioned in the enabled APIs and can serve as a data lake foundation.
resource "google_dataplex_lake" "mlops_feature_store_lake" {
  name     = "${var.project_id}-feature-store-lake"
  location = var.region
  project  = var.project_id

  labels = {
    environment = "dev"
  }

  description = "Dataplex Lake for MLOps Feature Store"

  depends_on = [google_project_service.apis]
}

# Vertex AI Metadata Store (part of Vertex AI)
# The Metadata Store is automatically available when Vertex AI API is enabled.
# We don't need a separate Terraform resource to "create" the Metadata Store itself,
# but we can ensure the API is enabled (which is done in main.tf).

# Vertex AI Pipeline (no specific resource to "create" the pipeline service,
# it's part of the Vertex AI platform enabled in main.tf. Pipelines are defined
# and run using the SDK or UI).

# You might define resources here related to Vertex AI Training, Endpoints, etc.
# as your MLOps pipeline evolves. For now, enabling the AI Platform API is sufficient
# for using Vertex AI Pipelines and other Vertex AI services.