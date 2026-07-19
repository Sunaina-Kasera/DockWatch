#!/bin/bash

recover_containers() {

    echo
    echo "Recovery Actions"
    echo "-----------------------------------------"

    recovered=0
    failed=0

    for container in $(docker ps -aq -f status=exited)
    do
        name=$(docker inspect --format='{{.Name}}' "$container" | cut -c2-)

        if docker start "$container" >/dev/null 2>&1; then
            echo "🔄 Starting $name ... ✅ Success"
            ((recovered++))
        else
            echo "🔄 Starting $name ... ❌ Failed"
            ((failed++))
        fi
    done

    echo
    echo "Summary"
    echo "-----------------------------------------"
    echo "Recovered : $recovered"
    echo "Failed    : $failed"
}