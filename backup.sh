#!/bin/bash
# Auto-Backup Script

set -e

# Load config
source "$(dirname "$0")/config.conf"

# Timestamp
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

echo "[INFO] Starting backup at $DATE"
tar -czf "$BACKUP_FILE" "${BACKUP_PATHS[@]}"

echo "[INFO] Backup saved at $BACKUP_FILE"

# Upload to Google Drive
rclone copy "$BACKUP_FILE" mydrive:backups
echo "[INFO] Backup uploaded to Google Drive."
