FROM postgres:15-bullseye
RUN apt-get update
RUN apt-get install -y curl zstd
RUN curl -fsSL -o rclone.deb https://github.com/rclone/rclone/releases/download/v1.62.2/rclone-v1.62.2-linux-amd64.deb
RUN dpkg -i rclone.deb
RUN rm -rf rclone.deb /var/lib/apt/lists/*
VOLUME /backups
WORKDIR /app
COPY backup-restore.sh .
RUN chmod 755 backup-restore.sh
ENTRYPOINT [ "./backup-restore.sh" ]
