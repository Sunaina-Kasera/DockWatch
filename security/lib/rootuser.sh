#!/bin/bash

check_root_user() {

    echo
    echo "Root User Check"
    echo "-----------------------------------------"

    for container in $(docker ps -q)
    do
        name=$(docker inspect --format='{{.Name}}' "$container" | cut -c2-)
        user=$(docker inspect --format='{{.Config.User}}' "$container")

        if [ -z "$user" ]; then
            echo "⚠ $name is running as root"
        else
            echo "✅ $name is running as $user"
        fi
    done
}