#!/bin/bash

CLI_PATH=${1}
BUCKET_NAME=${2}
RECORDS_FOLDER=${3}
OUTPUT_FOLDER=${4}
CONFIG_PATH=${5}
TPU_NAME=${6}

python3 "${CLI_PATH}/run_pretraining.py" \
  --input_file="gs://${BUCKET_NAME}/${RECORDS_FOLDER}/*.tfrecord" \
  --output_dir="gs://${BUCKET_NAME}/${OUTPUT_FOLDER}" \
  --bert_config_file="${CONFIG_PATH}" \
  --max_seq_length=512 \
  --max_predictions_per_seq=75 \
  --do_train=True  \
  --train_batch_size=128 \
  --num_train_steps=3000000 \
  --learning_rate=1e-4 \
  --save_checkpoints_steps=100000 \
  --keep_checkpoint_max=5 \
  --use_tpu=True \
  --tpu_name="${TPU_NAME}" \
  --num_tpu_cores=8