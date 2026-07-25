#!/bin/bash

check_root_user(){

echo
echo "Root User Check"
echo "-----------------------------------------"

count=0

for container in $(docker ps -q)
do

name=$(docker inspect --format='{{.Name}}' "$container" | cut -c2-)

user=$(docker inspect --format='{{.Config.User}}' "$container")

if [ -z "$user" ]; then

echo "⚠ $name"

((count++))

else

echo "✅ $name ($user)"

fi

done

echo
echo "Root Containers : $count"

}