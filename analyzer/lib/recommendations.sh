#!/bin/bash

generate_recommendations() {

echo
echo "Recommendations"
echo "-----------------------------------------"

unused_images=$(docker images -f dangling=true -q | wc -l)
unused_volumes=$(docker volume ls -qf dangling=true | wc -l)
stopped=$(docker ps -aq -f status=exited | wc -l)

if [ "$unused_images" -gt 0 ]; then
    echo "🗑 Remove $unused_images unused images"
fi

if [ "$unused_volumes" -gt 0 ]; then
    echo "💾 Remove $unused_volumes unused volumes"
fi

if [ "$stopped" -gt 0 ]; then
    echo "📦 Remove $stopped stopped containers"
fi

if [ "$unused_images" -eq 0 ] && \
   [ "$unused_volumes" -eq 0 ] && \
   [ "$stopped" -eq 0 ]; then
    echo "✅ Docker environment looks clean."
fi

}