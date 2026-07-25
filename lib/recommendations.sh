#!/bin/bash

generate_recommendations() {

    echo
    echo "Recommendations"
    echo "-----------------------------------------"

    stopped=$(docker ps -aq -f status=exited | wc -l)
    dangling_images=$(docker images -f dangling=true -q | wc -l)
    dangling_volumes=$(docker volume ls -qf dangling=true | wc -l)

    if [ "$stopped" -gt 0 ]; then
        echo "⚠ $stopped stopped container(s) found. Consider removing unused containers."
    fi

    if [ "$dangling_images" -gt 0 ]; then
        echo "⚠ $dangling_images dangling image(s) found. Run: docker image prune"
    fi

    if [ "$dangling_volumes" -gt 0 ]; then
        echo "⚠ $dangling_volumes unused volume(s) found. Run: docker volume prune"
    fi

    if [ "$stopped" -eq 0 ] && [ "$dangling_images" -eq 0 ] && [ "$dangling_volumes" -eq 0 ]; then
        echo "✅ Docker environment is healthy."
    fi
}