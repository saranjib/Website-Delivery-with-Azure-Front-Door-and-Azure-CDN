#!/bin/bash

set -e

echo "======================================"
echo " Azure Front Door CDN Deployment"
echo "======================================"

echo ""
echo "Initializing Terraform..."

terraform init

echo ""
echo "Validating Terraform..."

terraform validate

echo ""
echo "Creating Terraform plan..."

terraform plan

echo ""
echo "Applying infrastructure..."

terraform apply -auto-approve

echo ""
echo "======================================"
echo " Deployment Complete"
echo "======================================"

echo ""

terraform output
