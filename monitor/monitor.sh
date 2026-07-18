#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
NC="\e[0m"

source lib/stats.sh
source lib/alerts.sh
source lib/health.sh
source lib/summary.sh

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="output/monitor_$TIMESTAMP.log"

clear

{
echo "========================================="
echo "DockWatch Monitor"
echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Docker    : $(docker --version | cut -d' ' -f3 | tr -d ',')"
echo "Scan Time : $(date)"
echo "========================================="


show_container_stats

check_alerts
check_container_health
show_summary

echo
echo "========================================="
echo
} | tee "$LOG_FILE"

echo "📄 Log saved to $LOG_FILE"