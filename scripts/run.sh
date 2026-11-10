#!/usr/bin/env bash
for script in monitoring.sh audit.sh services.sh; do
    if [[ ${1:-} == --log ]]; then
        ./scripts/"$script" 2>&1 | tee -a run.log
    else
        ./scripts/"$script"
    fi
done
