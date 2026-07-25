#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/docker.sh"
source "$SCRIPT_DIR/lib/containers.sh"
source "$SCRIPT_DIR/lib/images.sh"
source "$SCRIPT_DIR/lib/networks.sh"
source "$SCRIPT_DIR/lib/volumes.sh"

echo "========================================="
echo "       🐳 DockWatch Inventory"
echo "========================================="
echo

check_docker_installed
check_docker_service
check_docker_version
get_container_info
get_image_info
get_network_info
get_volume_info

echo
echo "========================================="
echo " Inventory Scan Completed"
echo "========================================="
