#!/bin/bash

check_alerts() {

    echo
    echo "Alerts"
    echo "-----------------------------------------"

    docker stats --no-stream --format "{{.Name}} {{.CPUPerc}} {{.MemPerc}}" | while read name cpu mem
    do
        cpu=${cpu%\%}
        mem=${mem%\%}

        cpu_int=${cpu%.*}
        mem_int=${mem%.*}

        if [ "$cpu_int" -gt 80 ]; then
            echo "🚨 High CPU : $name ($cpu)"
        fi

        if [ "$mem_int" -gt 80 ]; then
            echo "🚨 High Memory : $name ($mem)"
        fi
    done

}
