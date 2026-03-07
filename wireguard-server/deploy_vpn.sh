#!/bin/bash
#
# Usage:
#    ./setup_vpn.sh <ip_address> <username> <command> [options]
#    Commands: deploy, backup_config, restore_config, status
#
# Examples:
#    ./setup_vpn.sh x.x.x.x <user> restore_config <backup_file>
#    ./setup_vpn.sh x.x.x.x <user> deploy
#
set -euo pipefail

cmd_helper() {
    echo "Usage: $0 <ip_address> <username> <command> [options]"
    echo "Commands: deploy, backup_config, restore_config, status"
    echo " Options:"
    echo "  backup_config: <backup_path>"
    echo "  restore_config: <backup_file>"
}

cmd_deploy() {
    echo ">>> Running deploy..."
    ssh "${USERNAME}@${IP_ADDRESS}" "bash -s" < setup_server.sh

    echo ">>> Deploying WireGuard..."
    ssh "${USERNAME}@${IP_ADDRESS}" "NAME=wireguard CONFIG_PATH=/home/${USERNAME}/wireguard docker compose -f - up -d" < docker-compose.yml
}

cmd_backup_config() {
    local dest="$1"
    if [[ ! -d "$dest" ]]; then
        echo "Error: backup directory not found: $dest"
        exit 1
    fi
    echo ">>> Backing up WireGuard config to ${dest}..."
    ssh "${USERNAME}@${IP_ADDRESS}" "tar -czf - -C /home/${USERNAME} wireguard" > "${dest}/wireguard-config.tar.gz"
}

cmd_restore_config() {
    local src="$1"
    if [[ ! -f "$src" ]]; then
        echo "Error: backup file not found: $src"
        exit 1
    fi
    echo ">>> Restoring WireGuard config from ${src}..."
    ssh "${USERNAME}@${IP_ADDRESS}" "mkdir -p /home/${USERNAME}/wireguard"
    ssh "${USERNAME}@${IP_ADDRESS}" "tar -xzf - -C /home/${USERNAME}" < "${src}"
}

cmd_status() {
    echo ">>> Checking WireGuard status..."
    ssh "${USERNAME}@${IP_ADDRESS}" "docker exec wireguard wg show"
}

if [[ $# -lt 3 ]]; then
    cmd_helper
    exit 1
fi

IP_ADDRESS="$1"
USERNAME="$2"
COMMAND="$3"
OPTIONS="${4:-}"

case "${COMMAND}" in
    deploy)
        cmd_deploy
        ;;
    backup_config)
        cmd_backup_config "${OPTIONS:-.}"
        ;;
    restore_config)
        cmd_restore_config "${OPTIONS:-./wireguard-config.tar.gz}"
        ;;
    status)
        cmd_status
        ;;
    *)
        cmd_helper
        exit 1
        ;;
esac
