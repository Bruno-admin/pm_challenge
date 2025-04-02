#!/bin/bash

# DATABASE ACCESS PARAMETERS
HOST="SET_IP/HOST"
PORT="SET_PORT"
USER="SET_USER"
PASSWORD="SET_PASSWORD"
BD_NAME="SET_BD_NAME"
CURRENT_DATETIME=$(date +"%Y-%m-%d_%H%M")

# BACKUP DIR
BACKUP_DIR="/backups"

# Create the backup
pg_dump -h $HOST -p $PORT -U $USER -d $BD_NAME -F c -f /tmp/db_backup.dump

# Will prompt a password
$PASSWORD

# Create and save as .tgz
tar -czf $BACKUP_DIR/bica-backup-${CURRENT_DATETIME}.tgz -C /tmp db_backup.dump
rm /tmp/db_backup.dump

# Encrypt the backup
openssl enc -aes-256-cbc -salt -pbkdf2 -in /backups/bica-backup-${CURRENT_DATETIME}.tgz -out /backups/bica-backup-${CURRENT_DATETIME}.tgz.enc
rm /backups/bica-backup-${CURRENT_DATETIME}.tgz
