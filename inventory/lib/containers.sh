#!/bin/bash

get_container_info() {
    echo
    echo "Containers"
    echo "-----------------------------------------"
    echo "Running : $(docker ps -q | wc -l)"
    echo "Stopped : $(docker ps -aq -f status=exited | wc -l)"
    echo "Total   : $(docker ps -aq | wc -l)"
}