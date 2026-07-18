#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"
NC="\e[0m"

check_docker_installed() {
    if command -v docker >/dev/null 2>&1; then
        echo -e "${GREEN}[✔] Docker Installed${NC}"
    else
        echo -e "${RED}[✘] Docker Not Installed${NC}"
    fi
}

check_docker_service() {
    if docker info >/dev/null 2>&1; then
        echo -e "${GREEN}[✔] Docker Engine Running${NC}"
    else
        echo -e "${RED}[✘] Docker Engine Not Running${NC}"
    fi
}

check_docker_version() {
    echo -e "${BLUE}[ℹ] $(docker --version)${NC}"
}

