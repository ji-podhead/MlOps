# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install any needed packages specified in requirements.txt
# Copy the requirements file first to leverage Docker cache
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the script into the container
COPY download_and_upload_dataset.py .

# Command to run the script (this will be overridden by Cloud Build)
CMD ["python", "download_and_upload_dataset.py"]