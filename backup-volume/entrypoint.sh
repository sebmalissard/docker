#!/bin/sh

DATE=$(date +"%Y-%m-%d_%H%M%S")
LOCAL

if [ "${MNT_BACKUP_DIR}" = "" ]; then
    echo "ERROR: MNT_BACKUP_DIR is not defined"
    exit 1
fi

BACKUP_DATE_DIR="/mnt/${MNT_BACKUP_DIR}/${DATE}"

mkdir -p "${BACKUP_DATE_DIR}"

volumes=$(docker volume ls -q)

echo "Volumes available: ${volumes}"

for volume in $volumes; do
    echo ""
    echo ">>> Backup ${volume}..."
    backup_file="backup_volume_${volume}_${DATE}.tar.gz"

    # Stop containers using this volume
    containers=$(docker ps -q --filter volume="${volume}")
    if [ -n "${containers}" ]; then
        echo "Stoping containers using this volume..."
        docker stop "${containers}"
    fi

    # Create backup
    docker run --rm -v "${volume}":/volume -v "${BACKUP_DATE_DIR}":/backup alpine sh -c "tar czvf \"/backup/${backup_file}\" -C /volume ."

    # Restart containers using this volume
    if [ -n "${containers}" ]; then
        echo "Re-starting containers using this volume..."
        docker start "${containers}"
    fi

    echo "Backup done for volume: ${volume}"
done

echo ""
echo "Waiting for termination signal..."

sleep infinity