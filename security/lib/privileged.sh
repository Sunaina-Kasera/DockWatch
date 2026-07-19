#!/bin/bash

check_privileged() {

    echo
    echo "Privileged Containers"
    echo "-----------------------------------------"

    found=0

    for container in $(docker ps -q)
    do
        privileged=$(docker inspect --format='{{.HostConfig.Privileged}}' "$container")
        name=$(docker inspect --format='{{.Name}}' "$container" | cut -c2-)

        if [ "$privileged" = "true" ]; then
            echo "⚠ $name is running in privileged mode"
            found=1
        fi
    done

    if [ "$found" -eq 0 ]; then
        echo "✅ No privileged containers found"
    fi
}