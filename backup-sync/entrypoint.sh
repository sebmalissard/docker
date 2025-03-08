#!/bin/sh

CONFIG_FILE="/root/.config/rclone/rclone.conf"

sed -i "s|@URL@|${URL}|g" "${CONFIG_FILE}"
sed -i "s|@USER@|${USER}|g" "${CONFIG_FILE}"
sed -i "s|@PASS@|${PASS}|g" "${CONFIG_FILE}"
sed -i "s|@CRYPT_PWD1@|${CRYPT_PWD1}|g" "${CONFIG_FILE}"
sed -i "s|@CRYPT_PWD2@|${CRYPT_PWD2}|g" "${CONFIG_FILE}"

echo "Synchronization started: $(date)"

rclone sync /mnt kcrypt: -v

echo "Synchronization finished: $(date)"

echo "Waiting for termination signal..."

sleep infinity