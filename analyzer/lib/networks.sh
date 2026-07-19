#!/bin/bash

analyze_networks() {

    echo
    echo "Network Analysis"
    echo "-----------------------------------------"

    total=$(docker network ls -q | wc -l)

    # User-defined networks (excluding default ones)
    custom=$(docker network ls --filter type=custom -q | wc -l)

    echo "Total Networks  : $total"
    echo "Custom Networks : $custom"
}