#!/usr/bin/env bash
set -e

SERVICES=("ssh" "cron")
REPORT="rapport_services_$(date +%F_%H%M).txt"

echo "Rapport des services du $(date)" | tee "$REPORT"
for svc in "${SERVICES[@]}"; do
    systemctl is-active --quiet "$svc"
    echo "[ACTIF] $svc" | tee -a "$REPORT"
done

##fait par ia je précise 