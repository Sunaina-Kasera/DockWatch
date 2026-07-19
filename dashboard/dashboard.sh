#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="output/dashboard_$TIMESTAMP.log"

clear

{
echo "========================================="
echo "        🚀 DockWatch Dashboard"
echo "========================================="
echo
echo "Host      : $(hostname)"
echo "User      : $(whoami)"
echo "Scan Time : $(date)"
echo

echo "Running Inventory..."
(cd ../inventory && ./inventory.sh)

echo
echo "Running Monitor..."
(cd ../monitor && ./monitor.sh)

echo
echo "Running Analyzer..."
(cd ../analyzer && ./analyzer.sh)

echo
echo "Running Recovery..."
(cd ../recovery && ./recovery.sh)

echo
echo "Running Security..."
(cd ../security && ./security.sh)

echo
echo "========================================="
echo "✅ DockWatch Scan Completed Successfully"
echo "========================================="

} | tee "$LOG_FILE"

echo
echo "📄 Dashboard report saved : $LOG_FILE"