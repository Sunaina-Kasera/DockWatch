#!/bin/bash

source lib/restart.sh

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="output/recovery_$TIMESTAMP.log"

clear

{
echo "========================================="
echo "       🐳 DockWatch Recovery"
echo "========================================="
echo
echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Scan Time : $(date)"

recover_containers

echo
echo "========================================="
} | tee "$LOG_FILE"

echo
echo "📄 Report saved : $LOG_FILE"