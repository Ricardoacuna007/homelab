#!/bin/bash
# Homelab initial setup script for Debian 13
# Run as root

set -e

echo "=== Homelab Setup Script ==="
echo "=== Installing dependencies ==="

apt update && apt upgrade -y
apt install -y curl wget git nano ufw htop

echo "=== Installing Docker ==="

apt install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list

apt update && apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "=== Creating directory structure ==="

mkdir -p /opt/homelab/{nginx-proxy,homepage,vaultwarden,filebrowser,couchdb,portainer,authelia/config,projects,cloudflared}

echo "=== Docker installed successfully ==="
docker --version
docker compose version

echo "=== Setup complete ==="
echo "Next: copy your docker-compose.yml and .env to /opt/homelab/ and run:"
echo "  cd /opt/homelab && docker compose up -d"