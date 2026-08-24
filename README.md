# Homelab — ricardo-acuna.com

Personal homelab running on a Dell OptiPlex 3080M with Proxmox VE, Docker, Cloudflare Tunnel and Authelia SSO.

## Hardware

| Component | Spec |
|---|---|
| Server | Dell OptiPlex 3080M |
| CPU | Intel Core i5-10500T (6 cores / 12 threads) |
| RAM | 16 GB DDR4 3200MHz |
| Storage | 256 GB NVMe SSD |
| Hypervisor | Proxmox VE 9.1.1 |

## Architecture

Internet → Cloudflare Tunnel → Nginx Proxy Manager → Authelia (SSO) → Services


Remote access via Tailscale VPN.

## Services

| Service | Description | URL |
|---|---|---|
| Homepage | Personal dashboard | home.ricardo-acuna.com |
| Vaultwarden | Password manager | vault.ricardo-acuna.com |
| Filebrowser | File manager | files.ricardo-acuna.com |
| Authelia | SSO Authentication | auth.ricardo-acuna.com |
| Portainer | Docker management | portainer.ricardo-acuna.com |
| Obsidian LiveSync | Notes sync via CouchDB | obsidian.ricardo-acuna.com |
| CarMan | Car workshop management system | taller.ricardo-acuna.com |

## Security

| Layer | Technology | Purpose |
|---|---|---|
| Tunnel | Cloudflare Tunnel | No open ports, all traffic through Cloudflare |
| Authentication | Authelia | SSO with username/password, 1 month session |
| VPN | Tailscale | Private mesh VPN for Proxmox access |
| Proxy | Nginx Proxy Manager | Reverse proxy with forward-auth |

## Repository Structure

homelab/
├── docker/
│ ├── docker-compose.yml # Main services stack
│ ├── .env.example # Environment variables template
│ └── services/
│ ├── authelia/ # Authelia configuration
│ ├── homepage/ # Dashboard configuration
│ └── carman/ # Workshop management system
├── docs/
│ ├── architecture.md # Detailed architecture docs
│ └── screenshots/ # Service screenshots
├── proxmox/
│ └── setup.md # Proxmox installation guide
└── scripts/
└── setup.sh # Initial setup script


## Stack

| Category | Technology |
|---|---|
| Hypervisor | Proxmox VE 9.1.1 |
| OS | Debian GNU/Linux 13 (Trixie) |
| Containers | Docker CE + Compose Plugin |
| Tunnel | Cloudflare Tunnel (cloudflared) |
| Proxy | Nginx Proxy Manager |
| Auth | Authelia v4 |
| VPN | Tailscale |

## Deployment

See [docs/architecture.md](docs/architecture.md) for the full deployment guide including Proxmox setup, VM creation, Docker installation and service configuration.

## Security Note

All secrets and credentials are stored in `.env` files which are not committed to this repository.
Copy `.env.example` and fill in your own values before deploying.
