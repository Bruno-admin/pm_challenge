#!/bin/bash

#Variables
BACKUP_DIR="/backups"
CURRENT_DATETIME=$(date +"%Y-%m-%d_%H%M")
TEMP_FILE="/tmp/db_backup.dump"
COMPRESSED_FILE="$BACKUP_DIR/bica-backup-$CURRENT_DATETIME.tgz"
ENCRYPTED_FILE="$COMPRESSED_FILE.enc"

echo "Starting PostgreSQL backup at $(date)..."

# Create the backup
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -F c -f "$TEMP_FILE"

if [ $? -ne 0 ]; then
    echo "Database backup failed!"
    exit 1
fi

echo "Compressing backup..."
tar -czf "$COMPRESSED_FILE" -C /tmp db_backup.dump
rm "$TEMP_FILE"

echo "Encrypting backup..."
openssl enc -aes-256-cbc -salt -pbkdf2 -in "$COMPRESSED_FILE" -out "$ENCRYPTED_FILE" -k "$ENCRYPTION_PASSWORD"
rm "$COMPRESSED_FILE"

echo "Backup completed successfully: $ENCRYPTED_FILE"