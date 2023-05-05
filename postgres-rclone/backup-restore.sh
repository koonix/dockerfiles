#!/bin/bash

# exit on errors
set -eu -o pipefail

dir=/backups
pfx=postgres-backup
conf=/etc/rclone.conf

set +u
[[ -z $BACKUP_COUNT ]] && BACKUP_COUNT=3
[[ -z $PGHOST ]] && PGHOST=localhost
[[ -z $PGPORT ]] && PGPORT=5432
[[ -z $PGUSER ]] && PGUSER=postgres

main()
{
	if [[ -n ${RCLONE_CONFIG:-} ]]; then
		printf '%s\n' '[remote]' "$RCLONE_CONFIG" > /etc/rclone.conf
	fi
	case ${1:-} in
		backup) backup ;;
		restore) restore ;;
		*) echo "usage: $0 backup|restore" >&2; exit 1 ;;
	esac
}

backup()
{
	echo 'backing up...'
	[[ $BACKUP_COUNT -lt 1 ]] && exit 1
	trap 'rm -f "$tmp"' EXIT
	tmp=$(mktemp)
	pg_dumpall --clean | zstd > "$tmp"
	for (( i = 1; i <= BACKUP_COUNT; i++ )); do
		if [[ $i -eq $BACKUP_COUNT ]]; then
			rm "$dir/$name.$i.zst"
		else
			mv "$dir/$name.$i.zst" "$dir/$name.$((i+1)).zst"
		fi
	done
	mv "$tmp" "$dir/$name.1.zst"
	rclone sync "remote:$REMOTE_PATH" "$dir"
	echo 'done.'
}

restore()
{
	echo 'restoring...'
	rclone sync "remote:$REMOTE_PATH" "$dir"
	unzstd  psql --username="$user"
	echo 'done.'
}

main "$@"
