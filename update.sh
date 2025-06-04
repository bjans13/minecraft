#!/bin/bash
BACKUP_DIR="/minecraft/backups"
LATEST_BACKUP=$(ls -t "$BACKUP_DIR" | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup found! Update aborted."
    exit 1
fi

echo "Stopping server..."
sudo systemctl stop minecraft

echo "Backing up server..."
sudo /minecraft/backup.sh

echo "Downloading latest version..."
cd /minecraft/bedrock
wget --no-check-certificate --user-agent="Mozilla/5.0" -O bedrock-server.zip https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.60.10.zip

echo "Extracting new files..."
unzip -o bedrock-server.zip
rm bedrock-server.zip

echo "Ensuring bedrock_server is executable..."
chmod +x /minecraft/bedrock/bedrock_server

echo "Update complete!"

echo "Restoring settings and worlds..."
sudo bash /minecraft/restore.sh