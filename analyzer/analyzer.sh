#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/containers.sh"
source "$SCRIPT_DIR/lib/images.sh"
source "$SCRIPT_DIR/lib/volumes.sh"
source "$SCRIPT_DIR/lib/networks.sh"
source "$SCRIPT_DIR/lib/recommendations.sh"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$SCRIPT_DIR/output/analyzer_$TIMESTAMP.log"

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
