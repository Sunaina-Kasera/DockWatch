#!/bin/bash

source lib/privileged.sh

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="output/security_$TIMESTAMP.log"

clear
source lib/rootuser.sh
source lib/exposedports.sh
{
echo "========================================="
echo "        🔒 DockWatch Security"
echo "========================================="
echo
echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Scan Time : $(date)"

check_privileged
check_root_user
check_exposed_ports

echo
echo "========================================="
} | tee "$LOG_FILE"

echo
echo "📄 Report saved : $LOG_FILE"