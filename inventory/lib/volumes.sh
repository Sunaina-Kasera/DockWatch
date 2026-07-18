#!/bin/bash

get_volume_info() {
    echo
    echo "Volumes"
    echo "-----------------------------------------"
    echo "Total Volumes : $(docker volume ls -q | wc -l)"
}