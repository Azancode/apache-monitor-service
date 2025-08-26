#!/bin/bash
# Restore Backup Script

if [ -z "$1" ]; then
    echo "Usage: $0 <backup-file.tar.gz>"
    exit 1
fi

BACKUP_FILE="$1"
echo "[INFO] Restoring from $BACKUP_FILE ..."
tar -xzf "$BACKUP_FILE" -C /
echo "[INFO] Restore complete."
