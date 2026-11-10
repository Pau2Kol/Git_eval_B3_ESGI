#!/usr/bin/env bash

echo "=== Lancement des scripts ==="

for script in monitoring.sh audit.sh services.sh
do
    echo ""
    echo "Exécution de : $script"
    echo "------------------------"

    ./scripts/"$script"
done

echo ""
echo "=== Fin de l'exécution ==="
