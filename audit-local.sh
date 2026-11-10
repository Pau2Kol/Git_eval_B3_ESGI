#!/usr/bin/env bash

if [[ ! -r /etc/passwd ]]; then
    printf '%s\n' 'Erreur : impossible de lire /etc/passwd.' >&2
    exit 1
fi

awk -F: '
    BEGIN {
        printf "%-24s %8s %8s  %-24s %s\n", "Compte", "UID", "GID", "Dossier personnel", "Shell"
    }
    {
        printf "%-24s %8s %8s  %-24s %s\n", $1, $3, $4, $6, $7
    }
' /etc/passwd
