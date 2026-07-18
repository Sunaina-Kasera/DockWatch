#!/bin/bash

source lib/docker.sh
source lib/containers.sh
source lib/images.sh
source lib/networks.sh
source lib/volumes.sh

clear

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
echo " Inventory Scan Completed "
echo "========================================="