#!/usr/bin/env bash

echo "=== Lancement des scripts ==="

for script in monitoring.sh audit.sh services.sh; do
    echo ""
    echo "Exécution de : $script"
    echo "------------------------"

    if [[ ${1:-} == --log ]]; then
        ./scripts/"$script" 2>&1 | tee -a run.log
    else
        ./scripts/"$script"
    fi
done

echo ""
echo "=== Fin de l'exécution ==="