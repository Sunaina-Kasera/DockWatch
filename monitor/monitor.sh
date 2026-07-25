#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
NC="\e[0m"

source "$SCRIPT_DIR/lib/stats.sh"
source "$SCRIPT_DIR/lib/alerts.sh"
source "$SCRIPT_DIR/lib/health.sh"
source "$SCRIPT_DIR/lib/summary.sh"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$SCRIPT_DIR/output/monitor_$TIMESTAMP.log"

{

echo "========================================="
echo "        📊 DockWatch Monitor"
echo "========================================="
echo
echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Docker    : $(docker --version | cut -d' ' -f3 | tr -d ',')"
echo "Scan Time : $(date)"
echo

show_container_stats

check_alerts
check_container_health
show_summary

echo
echo "========================================="
echo " Monitor Scan Completed"
echo "========================================="

} | tee "$LOG_FILE"

echo
echo "📄 Log saved to $LOG_FILE"