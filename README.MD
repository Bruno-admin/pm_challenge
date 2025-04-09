# Premium Minds Challenge
The goal of this project is to run a script to backup a PostGreSQL database.
+ The script must run inside a Docker;
+ Should backup ate 3AM and 14PM every day;
+ At 3AM it should delete old files from X days ago, this must be a variable;
+ In case of restart the Docker should go up without human intervention;
+ The database dump should be zipped and encrypted

## Build and Start the Container

```
docker-compose up --build -d
```

## Check If Cron is Running

```
docker logs postgres-backup
```

## Verify Cleanup

```
ls -lh /mnt/backups
```

## Decrypt lhe file later

```
openssl enc -aes-256-cbc -d -pbkdf2 -in [FILE].tgz.enc -out backup_YYYY-MM-DD_HH-MM-SS.tgz
```
```
tar -xzf backup_YYYY-MM-DD_HH-MM-SS.tgz
```