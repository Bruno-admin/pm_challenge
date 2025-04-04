
#!/bin/bash

echo "Running cleanup task at $(date)..."

# Run the backup first
/app/db_backup.sh

# Delete old backups
find /backups -type f -name "bica-backup-*" -mtime +$RETENTION_DATYS -exec rm {} \;

echo "Cleanup completed. Old backups removed."