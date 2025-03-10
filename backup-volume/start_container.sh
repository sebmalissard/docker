#!/bin/sh

export MNT_BACKUP_DIR="backup-test"

docker-compose -f docker-compose-test.yml up -d
