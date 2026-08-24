\#  Homelab — ricardo-acuna.com



Personal homelab running on a Dell OptiPlex 3080M with Proxmox VE, Docker, Cloudflare Tunnel and Authelia SSO.



\##  Hardware

\- \*\*Server:\*\* Dell OptiPlex 3080M

\- \*\*CPU:\*\* Intel Core i5-10500T (6 cores / 12 threads)

\- \*\*RAM:\*\* 16 GB DDR4 3200MHz

\- \*\*Storage:\*\* 256 GB NVMe SSD

\- \*\*Hypervisor:\*\* Proxmox VE 9.1.1



\##  Architecture

Internet → Cloudflare Tunnel → Nginx Proxy Manager → Authelia (SSO) → Services



Remote access via Tailscale VPN.



\##  Services

| Service | Description | URL |

|---|---|---|

| Homepage | Dashboard | home.ricardo-acuna.com |

| Vaultwarden | Password manager | vault.ricardo-acuna.com |

| Filebrowser | File manager | files.ricardo-acuna.com |

| Authelia | SSO Authentication | auth.ricardo-acuna.com |

| Portainer | Docker management | portainer.ricardo-acuna.com |

| Obsidian LiveSync | Notes sync (CouchDB) | obsidian.ricardo-acuna.com |

| CarMan | Car workshop management system | taller.ricardo-acuna.com |



\##  Security

\- \*\*Cloudflare Tunnel\*\* — No open ports, traffic through Cloudflare

\- \*\*Authelia\*\* — Single Sign-On with username/password (1 month session)

\- \*\*Tailscale\*\* — Private VPN mesh for Proxmox access

\- \*\*NPM\*\* — Reverse proxy with forward-auth



\##  Structure

homelab/

├── docker/

│ ├── docker-compose.yml # Main stack

│ ├── .env.example # Environment variables template

│ └── services/

│ ├── authelia/ # Authelia config

│ ├── homepage/ # Dashboard config

│ └── carman/ # Workshop management system

├── docs/

│ ├── architecture.md

│ └── screenshots/

├── proxmox/

│ └── setup.md

└── scripts/

└── setup.sh



\##  Stack

\- \*\*Proxmox VE\*\* — Hypervisor

\- \*\*Debian 13\*\* — VM OS

\- \*\*Docker + Compose\*\* — Container orchestration

\- \*\*Cloudflare Tunnel\*\* — Secure tunnel (no port forwarding)

\- \*\*Nginx Proxy Manager\*\* — Reverse proxy

\- \*\*Authelia\*\* — Authentication

\- \*\*Tailscale\*\* — VPN



\##  Deployment

See \[docs/architecture.md](docs/architecture.md) for full deployment guide.



\##  Security Note

All secrets and credentials are stored in `.env` files (not committed).

Use `.env.example` as template.

