Ensure that all variables are filled in in the environment part of the docker-compose.yml
ENCRYPTION_PASSWORD is for encrypting the database backup and RETENTION_DATYS is for how many days do you want to retain the backups.

copy the files in to the same location and run:

docker-compose up --build -d