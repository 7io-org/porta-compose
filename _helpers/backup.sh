#! /bin/bash -eu

BACKUP_FILENAME="backup-$(date '+%Y%m%d').tar.gz"

PROJ_PATH="$(readlink -f "$(cd "$(dirname "$(readlink -f $0)")" && pwd)")"
cd "${PROJ_PATH}/.."

docker-compose down
tar -czvf "${BACKUP_FILENAME}" "$@"
chown $(id -g):$(id -u) "${BACKUP_FILENAME}"
docker-compose up -d
