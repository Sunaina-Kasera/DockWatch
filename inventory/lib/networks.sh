#!/bin/bash

get_network_info() {
    echo
    echo "Networks"
    echo "-----------------------------------------"
    docker network ls --format "• {{.Name}}"
}