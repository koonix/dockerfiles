# postgres-rclone

`docker pull koonix/postgres-rclone:1`

Backup and restore a PostgreSQL database using rclone.

## Usage

```sh
docker run \
	--env REMOTE_PATH:bucket/postgres \
	--volume ./rclone.conf:/etc/rclone.conf \
	koonix:postgres-rclone:1
```

## Notes

Specify rclone's remote config one of these two ways: 

- Mount it at `/etc/rclone.conf` with the section header set to `[remote]`
- Provide the config as the `RCLONE_CONFIG` environment variable (without the `[remote]` section header).

## Volumes

| Volume                        | Description
|-------------------------------|-------------------------------------------
| `/backups`                    | Backups are stored here
| `/etc/rclone.conf`            | rclone's config file (remote should be names `remote`)

## Environment Variables

| Variable                      | Default            | Description
|-------------------------------|--------------------|----------------------
| `REMOTE_PATH` (Required)      |                    | Remote dir path to backup to and restore from
| `RCLONE_CONFIG` (Required)    |                    | rclone's config (if not provided as a volume)
| `BACKUP_COUNT`                | `3`                |
| `PGHOST`                      | `localhost`        |
| `PGPORT`                      | `5432`             |
| `PGUSER`                      | `postgres`         |
| `PGPASSWORD`                  |                    |
