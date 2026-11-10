#!/usr/bin/env bash
set -e

SERVICES=("ssh" "cron")
REPORT="rapport_services_$(date +%F_%H%M).txt"

echo "Rapport des services du $(date)" | tee "$REPORT"
for svc in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$svc"; then
        echo "[ACTIF] $svc" | tee -a "$REPORT"
    else
        echo "[ARRÊTÉ] $svc" | tee -a "$REPORT"
    fi
done

##fait par ia je précise