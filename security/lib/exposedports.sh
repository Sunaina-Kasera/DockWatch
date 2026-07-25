#!/bin/bash

check_exposed_ports(){

echo
echo "Exposed Ports"
echo "-----------------------------------------"

docker ps --format "{{.Names}} {{.Ports}}"

count=$(docker ps --format "{{.Ports}}" | grep -c ":")

echo
echo "Exposed Ports Count : $count"

}