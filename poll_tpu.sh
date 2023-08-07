#!/bin/bash

# Variables
ZONE="europe-west4-a"
TPU_NAME=${1}
ACCELERATOR_TYPE="v3-8"
NETWORK="default"
VERSION="2.9.1"
SLEEP_TIME=300 # 5 minutes in seconds

# Function to create TPU
create_tpu() {
  echo "Trying to create TPU: ${TPU_NAME} in zone: ${ZONE}"
  gcloud compute tpus create "${TPU_NAME}" --zone=${ZONE} --accelerator-type=${ACCELERATOR_TYPE} \
    --network=${NETWORK} --version=${VERSION}
}

# Main loop
while true; do
  create_tpu
  RESULT=$?
  if [ ${RESULT} -eq 0 ]; then
    echo "TPU creation successful!"
    exit 0
  else
    echo "TPU creation failed. Retrying in ${SLEEP_TIME} seconds..."
    sleep ${SLEEP_TIME}
  fi
done
