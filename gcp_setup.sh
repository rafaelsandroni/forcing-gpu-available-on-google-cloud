#!/bin/bash

# Set variables
PROJECT_ID="PROJECT_NAME"
INSTANCE_NAME="my-colab-instance"
MACHINE_TYPE="g2-standard-8"
GPU_TYPE="nvidia-l4"
GPU_COUNT=1

# Set the project and compute zone
gcloud config set project $PROJECT_ID
# List all available zones
ZONES=$(gcloud compute zones list --format="value(name)")
# Loop through each zone
for ZONE in $ZONES; do
    echo "Attempting to create instance in zone: $ZONE"
    gcloud config set compute/zone $ZONE
    
    # Try to create the GCP instance with the specified machine type and GPU
    if gcloud compute instances create $INSTANCE_NAME \
        --machine-type $MACHINE_TYPE \
        --accelerator type=$GPU_TYPE,count=$GPU_COUNT \
        --maintenance-policy TERMINATE --restart-on-failure \
        --metadata "install-nvidia-driver=True"; then
        echo "Instance created successfully in zone: $ZONE"
        break
    else
        echo "Failed to create instance in zone: $ZONE. Trying next zone..."
    fi
done

# Connect to the instance and install Jupyter Notebook
gcloud compute ssh my-colab-instance \
    --command sudo apt-get update && \
    sudo apt-get install -y python3-pip && \
    pip3 install jupyter && \
    jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root

# Instructions to access Jupyter Notebook
echo "To access Jupyter Notebook, use the following command:"
echo "gcloud compute ssh --zone $ZONE $INSTANCE_NAME -- -L 8888:localhost:8888"
echo "Then open your browser and navigate to http://localhost:8888"
