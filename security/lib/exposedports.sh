#!/bin/bash

check_exposed_ports() {

    echo
    echo "Exposed Ports"
    echo "-----------------------------------------"

    docker ps --format "table {{.Names}}\t{{.Ports}}"
}