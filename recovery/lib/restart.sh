#!/bin/bash

recover_containers() {

    echo
    echo "Recovery Status"
    echo "-----------------------------------------"

    stopped=$(docker ps -aq -f status=exited | wc -l)
    running=$(docker ps -q | wc -l)

    echo "Running Containers : $running"
    echo "Stopped Containers : $stopped"

    echo
    echo "Suggested Recovery"
    echo "-----------------------------------------"

    if [ "$stopped" -gt 0 ]; then
        echo "🔄 Restart stopped containers"
        echo "🧹 Remove stopped containers"
    else
        echo "✅ No stopped containers found"
    fi

    echo
    echo "Suggested Commands"
    echo "-----------------------------------------"

    echo "docker start <container>"
    echo "docker restart <container>"
    echo "docker rm \$(docker ps -aq -f status=exited)"
    echo "docker system prune -f"

}