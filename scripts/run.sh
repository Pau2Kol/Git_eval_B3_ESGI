#!/usr/bin/env bash
for script in monitoring.sh audit.sh services.sh; do
    ./scripts/"$script"
done