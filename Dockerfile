# Use a lightweight Linux image
FROM debian:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    openssl \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the backup script
COPY backup.sh /app/backup.sh
RUN chmod +x /app/backup.sh

# Run the backup script when the container starts
CMD ["/bin/bash", "/app/backup.sh"]
