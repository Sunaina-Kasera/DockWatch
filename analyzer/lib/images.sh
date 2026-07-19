#!/bin/bash

analyze_images() {

    echo
    echo "Image Analysis"
    echo "-----------------------------------------"

    total=$(docker images -q | sort -u | wc -l)
    dangling=$(docker images -f dangling=true -q | wc -l)

    # Images not used by any container
    unused=$(comm -23 \
        <(docker images --format "{{.Repository}}:{{.Tag}}" | sort) \
        <(docker ps -a --format "{{.Image}}" | sort | uniq) | wc -l)

    echo "Total Images    : $total"
    echo "Unused Images   : $unused"
    echo "Dangling Images : $dangling"
}