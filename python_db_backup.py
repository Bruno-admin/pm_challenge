import os
import datetime

#Variables
BACKUP_DIR="/backups"
GET_DATETIME=datetime.datetime.now()
CURRENT_DATETIME=GET_DATETIME.strftime("%Y-%m-%d_%H%M")
TEMP_FILE="/tmp/db_backup.dump"
COMPRESSED_FILE="$BACKUP_DIR/bica-backup-$CURRENT_DATETIME.tgz"
ENCRYPTED_FILE="$COMPRESSED_FILE.enc"
ENCRYPTION_PASSWORD=os.getenv("ENCRYPTION_PASSWORD")
pg_password=os.getenv("POSTGRES_PASSWORD")
pg_user=os.getenv("POSTGRES_USER")
pg_host=os.getenv("POSTGRES_HOST")
pg_db=os.getenv("POSTGRES_DB")

print("Starting PostgreSQL backup at " + str(GET_DATETIME) + "...")

# Create the backup

print(f"PGPASSWORD={pg_password} pg_dump -h {pg_host} -U {pg_user} -d {pg_db} -F c -f {TEMP_FILE}")

print("Compressing backup...")

print(f"tar -czf {COMPRESSED_FILE} -C {TEMP_FILE}")
print(f"rm {TEMP_FILE}")

print("Encrypting backup...")
print(f"openssl enc -aes-256-cbc -salt -pbkdf2 -in {COMPRESSED_FILE} -out {ENCRYPTED_FILE} -k {ENCRYPTION_PASSWORD}")
print(f"rm {COMPRESSED_FILE}")

print(f"Backup completed successfully: {ENCRYPTED_FILE}")