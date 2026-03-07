#!/bin/bash
#
# IP_ADDRESS=x.x.x.x
#
# Push on server:
#    scp setup_server.sh ubuntu@${IP_ADDRESS}:~/
#
# Run remotely on server:
# ssh ubuntu@${IP_ADDRESS} "bash ~/setup_server.sh"


cmd_update() {
    echo "Updating system packages..."
    sudo apt-get update
    sudo apt-get -y upgrade
}

cmd_install() {
    if ! command -v docker &>/dev/null; then
        echo "Docker not found. Installing Docker..."

        # Add Docker's official GPG key:
        sudo apt-get -y install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        # Add the repository to Apt sources:
        sudo tee /etc/apt/sources.list.d/docker.sources <<-EOF
		Types: deb
		URIs: https://download.docker.com/linux/ubuntu
		Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
		Components: stable
		Signed-By: /etc/apt/keyrings/docker.asc
		EOF

        # Install Docker Engine:
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-compose-plugin
        sudo usermod -aG docker "${USER}"

        # Test Docker installation
        sudo docker run hello-world
    else
        echo "Docker is already installed."
    fi
}

cmd_update
cmd_install
