#!/bin/bash
BACKUP_DIR="/minecraft/backups"
LATEST_BACKUP=$(ls -t "$BACKUP_DIR" | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup found! Restore aborted."
    exit 1
fi

echo "Stopping server..."
sudo systemctl stop minecraft

echo "Restoring worlds, server.properties, and permissions.json from backup..."
cd /minecraft/bedrock
tar -xzvf "$BACKUP_DIR/$LATEST_BACKUP" -C /minecraft/bedrock --strip-components=1 ./server.properties ./worlds
tar -xzvf "$BACKUP_DIR/$LATEST_BACKUP" -C /minecraft/bedrock/config/default --strip-components=3 ./config/default/permissions.json

echo "Ensuring bedrock_server is executable..."
chmod +x /minecraft/bedrock/bedrock_server

echo "Starting server..."
sudo systemctl start minecraft

echo "Restore complete!"