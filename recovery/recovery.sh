#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/restart.sh"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$SCRIPT_DIR/output/recovery_$TIMESTAMP.log"

{

echo "========================================="
echo "       🐳 DockWatch Recovery"
echo "========================================="
echo

echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Scan Time : $(date)"
echo

echo "Recovery Status"
echo "-----------------------------------------"
echo "Unused Images      : $(docker images -f dangling=true -q | wc -l)"
echo "Unused Volumes     : $(docker volume ls -qf dangling=true | wc -l)"
echo "Running Containers : $(docker ps -q | wc -l)"
echo "Stopped Containers : $(docker ps -aq -f status=exited | wc -l)"

recover_containers

echo
echo "========================================="
echo " Recovery Scan Completed "
echo "========================================="

} | tee "$LOG_FILE"

echo
echo "📄 Report saved : $LOG_FILE"