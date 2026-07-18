#!/bin/bash

source lib/docker.sh
source lib/containers.sh

clear

echo "========================================="
echo "       🐳 DockWatch Inventory"
echo "========================================="
echo

check_docker_installed
check_docker_service
check_docker_version
get_container_info

echo
echo "========================================="
echo " Inventory Scan Completed "
echo "========================================="