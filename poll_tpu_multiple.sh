#!/bin/bash

# Variables
ZONE="europe-west4-a"
ACCELERATOR_TYPE="v3-8"
NETWORK="default"
VERSION="2.9.1"
SLEEP_TIME=120 # 2 minutes in seconds

# Function to create TPU
create_tpu() {
  TPU_NAME=$1
  echo "Trying to create TPU: ${TPU_NAME} in zone: ${ZONE}"
  gcloud compute tpus create "${TPU_NAME}" --zone=${ZONE} --accelerator-type=${ACCELERATOR_TYPE} \
    --network=${NETWORK} --version=${VERSION}
}

# Main loop
for TPU_NAME in "$@"; do
  while true; do
    create_tpu ${TPU_NAME}
    RESULT=$?
    if [ ${RESULT} -eq 0 ]; then
      echo "TPU creation successful for ${TPU_NAME}!"
      break # Move to the next TPU in the list
    else
      echo "TPU creation failed for ${TPU_NAME}. Retrying in ${SLEEP_TIME} seconds..."
      sleep ${SLEEP_TIME}
    fi
  done
done

echo "All TPUs created successfully!"
exit 0