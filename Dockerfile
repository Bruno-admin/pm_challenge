# Use a lightweight Linux image
FROM debian:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    openssl \
    tar \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the backup script
COPY db_backup.sh /app/db_backup.sh
COPY db_retention_days.sh /app/db_retention_days.sh
RUN chmod +x /app/backup.sh /app/db_retention_days.sh


# Create cron jobs
RUN echo "0 14 * * * /app/db_backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/backup \
    && echo "0 3 * * * /app/db_retention_days.sh >> /var/log/cron.log 2>&1" >> /etc/cron.d/backup \
    && chmod 0644 /etc/cron.d/backup \
    && crontab /etc/cron.d/backup

# Start cron in the foreground
CMD ["cron", "-f"]
