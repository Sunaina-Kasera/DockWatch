#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/privileged.sh"
source "$SCRIPT_DIR/lib/rootuser.sh"
source "$SCRIPT_DIR/lib/exposedports.sh"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$SCRIPT_DIR/output/security_$TIMESTAMP.log"

{

echo "========================================="
echo "        🔒 DockWatch Security"
echo "========================================="
echo
echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Scan Time : $(date)"
echo

echo "Security Summary"
echo "-----------------------------------------"
echo "Running Containers : $(docker ps -q | wc -l)"
echo

check_privileged
check_root_user
check_exposed_ports

echo
echo "========================================="
echo " Security Scan Completed"
echo "========================================="

} | tee "$LOG_FILE"

echo
echo "📄 Report saved : $LOG_FILE"