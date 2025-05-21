#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <size-in-GB>"
  exit 1
fi

VOLUME_ID=$(curl -s http://169.254.169.254/latest/meta-data/block-device-mapping/ebs1)
aws ec2 modify-volume --volume-id $VOLUME_ID --size $1

echo "Requested volume resize to $1 GB"
