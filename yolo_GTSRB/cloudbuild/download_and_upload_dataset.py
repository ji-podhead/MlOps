import kagglehub
import os
import sys
from google.cloud import storage

def download_kaggle_dataset(dataset_id="meowmeowmeowmeowmeow/gtsrb-german-traffic-sign"):
    """Downloads a dataset from Kaggle."""
    print(f"Downloading dataset: {dataset_id}")
    try:
        # Download latest version
        path = kagglehub.dataset_download(dataset_id)
        print(f"Dataset downloaded to: {path}")
        return path
    except Exception as e:
        print(f"Error downloading dataset: {e}")
        sys.exit(1)

def upload_directory_to_gcs(local_directory, bucket_name, destination_prefix="datasets/gtsrb/"):
    """Uploads a local directory to a GCS bucket."""
    print(f"Uploading directory {local_directory} to gs://{bucket_name}/{destination_prefix}")
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)

    for root, _, files in os.walk(local_directory):
        for file in files:
            local_file_path = os.path.join(root, file)
            # Create the destination path in GCS, maintaining the directory structure
            relative_path = os.path.relpath(local_file_path, local_directory)
            gcs_path = os.path.join(destination_prefix, relative_path)

            print(f"Uploading {local_file_path} to {gcs_path}")
            blob = bucket.blob(gcs_path)
            try:
                blob.upload_from_filename(local_file_path)
                print(f"Successfully uploaded {file}")
            except Exception as e:
                print(f"Error uploading {file}: {e}")
                # Decide if you want to exit on error or continue
                sys.exit(1)

    print("Upload complete.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python download_and_upload_dataset.py <gcs_bucket_name>")
        sys.exit(1)

    gcs_bucket_name = sys.argv[1]
    dataset_local_path = download_kaggle_dataset()

    if dataset_local_path:
        # The downloaded path might be the dataset root or a directory containing the dataset.
        # We need to find the actual data directory. For GTSRB, it's usually the extracted zip content.
        # Let's assume the downloaded path is the parent directory of the dataset content.
        # We might need to adjust this based on how kagglehub extracts the dataset.
        # For simplicity, let's assume the downloaded path is the directory containing the data files/folders.
        # If the structure is different, this part needs adjustment.
        # A common structure after extraction might be dataset_name/data_files...
        # Let's try to find a subdirectory if the downloaded path is not the data itself.
        content_path = dataset_local_path
        # Simple check: if the downloaded path contains a single directory, use that.
        items = os.listdir(content_path)
        if len(items) == 1 and os.path.isdir(os.path.join(content_path, items[0])):
             content_path = os.path.join(content_path, items[0])
             print(f"Assuming dataset content is in subdirectory: {content_path}")


        if os.path.isdir(content_path):
             upload_directory_to_gcs(content_path, gcs_bucket_name)
        else:
             print(f"Downloaded path {content_path} is not a directory. Cannot upload.")
             sys.exit(1)