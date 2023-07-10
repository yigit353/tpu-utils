#!/bin/bash

# Variables
VM_NAME=${1}
ZONE="europe-west4-a"
BOOT_DISK_SIZE="300GB"

create_vm() {
  VM_NAME=$1
  echo "Trying to create VM: ${VM_NAME} in zone: ${ZONE}"
  gcloud compute instances create "${VM_NAME}" \
    --zone=${ZONE} \
    --machine-type=n1-standard-1 \
    --image-project=ml-images \
    --image-family=tf-1-15-3 \
    --scopes=cloud-platform \
    --boot-disk-size=${BOOT_DISK_SIZE}
}

create_vm "${VM_NAME}"
