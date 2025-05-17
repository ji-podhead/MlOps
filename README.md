# MLOps Project for YOLO Training on Google Cloud with Terraform

This project sets up the basic Google Cloud infrastructure for an MLOps project to train a YOLO model using Terraform.

## Prerequisites

*   Google Cloud SDK installed and configured.
*   Terraform installed.
*   A Google Cloud project with billing enabled.

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
    Edit the [`terraform.tfvars`](terraform.tfvars) file and replace the placeholders with your Google Cloud Project ID and desired region.

    ```hcl
    project_id = "YOUR_PROJECT_ID"
    region     = "YOUR_REGION"
    ```
    *(Note: We have already configured this for you with `project_id = "mlops-460000"` and `region = "us-central1"`.)*

4.  **Initialize Terraform:**
    Navigate to the project directory in your terminal and run the following command to initialize Terraform and download the required providers:
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

## Terraform Files

*   [`variables.tf`](variables.tf): Defines the input variables for the project and region.
*   [`terraform.tfvars`](terraform.tfvars): Contains the specific values for your project ID and region.
*   [`main.tf`](main.tf): Configures the Google Cloud Provider and enables the necessary APIs.
*   [`storage.tf`](storage.tf): Creates a Cloud Storage Bucket for storing data and model artifacts.
*   [`artifact_registry.tf`](artifact_registry.tf): Creates an Artifact Registry Repository for storing Docker images for pipeline components.

## Next Steps

Once the infrastructure is provisioned, you can proceed with implementing the MLOps pipeline. This involves:

*   Developing the TFX pipeline components (data preprocessing, training, evaluation, etc.).
*   Containerizing the pipeline components.
*   Defining the Vertex AI Pipeline to orchestrate the components.
*   Setting up Cloud Build triggers for CI/CD.
*   Adapting the training code for the YOLO model (based on Ultralytics YOLOv5 or YOLOv8) to run on Vertex AI Training.