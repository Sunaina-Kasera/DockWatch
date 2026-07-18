#!/bin/bash

check_container_health() {

    echo
    echo "Health Status"
    printf "%-20s %-15s %-15s\n" "Container" "Status" "Health"
    echo "------------------------------------------------------------"

    docker ps --format "{{.Names}}" | while read container
    do
        status=$(docker inspect --format='{{.State.Status}}' "$container")
        health=$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}N/A{{end}}' "$container")

        if [ "$status" = "running" ]; then
            icon="🟢"
        else
            icon="🔴"
        fi

        printf "%-20s %-15s %-15s\n" "$container" "$icon $status" "$health"
    done
}