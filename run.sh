#!/bin/bash

# Initial configurations
PROJECT_NAME=$(basename "$(realpath .)")
IMAGE_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
FULL_PATH=$(realpath .)
DOCKERFILE_PATH="./Dockerfile"

# Function to display colored messages
echo_error() {
    echo -e "\e[31m[ERROR]\e[0m LUT2GPU"
}
echo_success() {
    echo -e "\e[32m[SUCCESS]\e[0m LUT2GPU"
}
echo_info() {
    echo -e "\e[34m[INFO]\e[0m LUT2GPU"
}

# Run the container with default settings
echo_success "Running container: $IMAGE_NAME"
docker run --gpus all --rm -d   -p 8888:8888 --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 --name "$IMAGE_NAME" -v "$FULL_PATH:/app" "$IMAGE_NAME" jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='101'