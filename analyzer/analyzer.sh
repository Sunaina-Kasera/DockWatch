#!/bin/bash

source lib/containers.sh

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="output/analyzer_$TIMESTAMP.log"

clear
source lib/images.sh
source lib/volumes.sh
source lib/networks.sh
source lib/recommendations.sh
{
echo "========================================="
echo "       🐳 DockWatch Analyzer             "
echo "========================================="
echo
echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Scan Time : $(date)"

analyze_containers
analyze_images
analyze_volumes
analyze_networks
generate_recommendations

echo
echo "========================================="
} | tee "$LOG_FILE"

echo
echo "📄 Report saved : $LOG_FILE"
