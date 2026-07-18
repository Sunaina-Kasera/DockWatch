#!/bin/bash

show_container_stats() {

    echo
    echo "Container Resource Usage"
    echo "-----------------------------------------"

    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"

}
