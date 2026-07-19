#!/bin/bash

analyze_containers() {

    echo
    echo "Container Analysis"
    echo "-----------------------------------------"

    running=$(docker ps -q | wc -l)
    stopped=$(docker ps -aq -f status=exited | wc -l)
    total=$(docker ps -aq | wc -l)

    echo "Running Containers : $running"
    echo "Stopped Containers : $stopped"
    echo "Total Containers   : $total"
}