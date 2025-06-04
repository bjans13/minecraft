#!/bin/bash
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/minecraft/backups"
WORLD_DIR="/minecraft/bedrock/worlds"

mkdir -p "$BACKUP_DIR"
tar --exclude="/minecraft/backups" -czvf "$BACKUP_DIR/minecraft_backup_$TIMESTAMP.tar.gz" -C /minecraft/bedrock .

echo "Backup completed: $BACKUP_DIR/minecraft_backup_$TIMESTAMP.tar.gz"

# Keep only the last 30 days of backups
find "$BACKUP_DIR" -type f -name "minecraft_backup_*.tar.gz" -mtime +30 -delete