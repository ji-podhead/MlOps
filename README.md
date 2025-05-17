# MLOps Project for YOLO Training on Google Cloud with Terraform

This project sets up the basic Google Cloud infrastructure for an MLOps project to train a YOLO model for traffic sign classification using Terraform.

## Prerequisites

*   Google Cloud SDK installed and configured.
*   Terraform installed.
*   A Google Cloud project with billing enabled.

## Project Structure

```
.
├── main.tf         # Root main.tf (calls the module)
├── variables.tf    # Root variables
├── terraform.tfvars # Root variable values
├── README.md       # This file
└── yolo_GTSRB/
    ├── initialize_google/ # The module for Google Cloud infrastructure
    │   ├── main.tf        # Module entrypoint (contains Provider, API activation, etc.)
    │   ├── variables.tf   # Module variables
    │   ├── storage.tf     # Storage resources (GCS Bucket)
    │   ├── artifact_registry.tf # Artifact Registry resources
    │   ├── vertex_ai.tf   # Vertex AI resources (Dataset, Feature Store Lake)
    │   └── outputs.tf     # Module outputs
    ├── cloudbuild/        # Cloud Build files for dataset download/upload
    │   ├── download_and_upload_dataset.py
    │   ├── Dockerfile
    │   ├── requirements.txt
    │   └── cloudbuild.yaml
    └── terraform.tfstate  # State file for the root configuration (created after terraform apply)
```

## Setup

1.  **Clone the Repository:**
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2.  **Configure Your Google Cloud Credentials:**
    Ensure you are authenticated with Google Cloud and have Application Default Credentials (ADC) set up. Run the following command:
    ```bash
    gcloud auth application-default login
    ```
    Follow the browser instructions to complete the authentication.

3.  **Configure Project ID and Region:**
    Edit the [`terraform.tfvars`](terraform.tfvars) file in the **root directory** and replace the placeholders with your Google Cloud Project ID and desired region.

    ```hcl
    project_id = "YOUR_PROJECT_ID"
    region     = "YOUR_REGION"
    ```
    *(Note: We have already configured this for you with `project_id = "mlops-460011"` and `region = "us-central1"`.)*

4.  **Initialize Terraform:**
    Navigate to the **root project directory** in your terminal and run the following command to initialize Terraform and download the required providers and modules:
    ```bash
    terraform init
    ```

5.  **Review the Execution Plan (Optional):**
    You can review the execution plan to see which resources Terraform will create:
    ```bash
    terraform plan
    ```

6.  **Apply the Configuration:**
    Apply the Terraform configuration to provision the Google Cloud infrastructure:
    ```bash
    terraform apply
    ```
    You will be prompted to confirm the action. Type `yes` and press Enter. Alternatively, you can use `--auto-approve` to skip the confirmation (use with caution).

## Provisioned Google Cloud Resources

The `initialize_google` module provisions the following core Google Cloud resources:

*   **Enabled APIs:** Activates necessary APIs including Compute Engine, Cloud Storage, Artifact Registry, Cloud Build, Vertex AI, Dataflow, Cloud Resource Manager, Data Lineage, Dataplex, Notebooks, Dataform, Vision AI, Container, Cloud Functions, and Pub/Sub.
*   **Cloud Storage Bucket:** A bucket for storing raw data, processed data, and model artifacts.
*   **Artifact Registry Repository:** A Docker repository for storing container images used in the MLOps pipeline.
*   **Vertex AI Dataset:** A dataset resource configured for Image Classification, referencing the Cloud Storage bucket as the data source location for future imports.
*   **Vertex AI Feature Store (Conceptual):** A Dataplex Lake is provisioned as a conceptual foundation for a Feature Store.
*   **Vertex AI Metadata Store:** Automatically available with the Vertex AI API, used for tracking MLOps pipeline runs and artifacts.

## Dataset Download and Upload

An automated process using Cloud Build is configured to download the GTSRB dataset from Kaggle and upload it to the created Cloud Storage bucket.

To trigger this process:

1.  Ensure the Google Cloud infrastructure is provisioned using Terraform (`terraform init` and `terraform apply`).
2.  Run the following command in the **root project directory**:
    ```bash
    gcloud builds submit --config yolo_GTSRB/cloudbuild/cloudbuild.yaml .
    ```
    This command builds a Docker image, pushes it to Artifact Registry, and executes a Python script within the container to perform the download and upload.

## Next Steps

Once the infrastructure is provisioned and the dataset is uploaded to Cloud Storage, you can proceed with implementing the MLOps pipeline for YOLOv11 traffic sign classification. This involves:

*   Developing the TFX pipeline components (data preprocessing, training on Vertex AI Training, evaluation, etc.).
*   Defining the Vertex AI Pipeline to orchestrate these components.
*   Setting up Cloud Build triggers for CI/CD to automate pipeline execution.
*   Adapting the YOLOv11 training code to work with the prepared dataset and run on Vertex AI Training.