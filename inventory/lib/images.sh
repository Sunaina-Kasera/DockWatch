#!/bin/bash

get_image_info() {
    echo
    echo "Images"
    echo "-----------------------------------------"
    echo "Total Images : $(docker images -q | sort -u | wc -l)"
    echo "Dangling     : $(docker images -f dangling=true -q | wc -l)"
}