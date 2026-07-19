#!/bin/bash

analyze_volumes() {

    echo
    echo "Volume Analysis"
    echo "-----------------------------------------"

    total=$(docker volume ls -q | wc -l)

    # Unused (dangling) volumes
    unused=$(docker volume ls -qf dangling=true | wc -l)

    echo "Total Volumes  : $total"
    echo "Unused Volumes : $unused"
}