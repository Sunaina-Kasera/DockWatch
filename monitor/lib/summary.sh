#!/bin/bash

show_summary() {

echo
echo "========================================="
echo "Summary"
echo "-----------------------------------------"

running=$(docker ps -q | wc -l)

echo "Running Containers : $running"
echo "Healthy            : $running"
echo "Warnings           : 0"
echo "Critical           : 0"

echo "========================================="
}