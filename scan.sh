#!/bin/bash

IMAGE=$1

trivy image --severity HIGH,CRITICAL --exit-code 1 $IMAGE

if [ $? -eq 0 ]; then
  echo "✅ Image passed security scan"
else
  echo "❌ Image failed security scan"
  exit 1
fi
