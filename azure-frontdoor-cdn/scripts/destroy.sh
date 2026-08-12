#!/bin/bash

set -e

echo "======================================"
echo " Destroy Azure Front Door CDN"
echo "======================================"

terraform destroy -auto-approve

echo ""
echo "All Azure resources have been removed."
