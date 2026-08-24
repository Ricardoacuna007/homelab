\# Architecture



\## Overview



This homelab runs on a Dell OptiPlex 3080M as a dedicated server with Proxmox VE as the hypervisor. All services run inside a Debian 13 VM using Docker Compose.



\## Network Flow



User → Cloudflare DNS → Cloudflare Tunnel → Nginx Proxy Manager → Authelia → Service





For private access:



Device (Tailscale) → Proxmox VE (100.67.65.90:8006)





\## Layers



\### Layer 1 — Hardware

\- Dell OptiPlex 3080M running 24/7

\- Connected via Gigabit Ethernet to home router

\- No ports open on the router



\### Layer 2 — Hypervisor

\- Proxmox VE 9.1.1 installed bare metal on the NVMe SSD

\- Manages VMs and snapshots

\- Accessible remotely via Tailscale VPN



\### Layer 3 — Virtual Machine

\- Debian GNU/Linux 13 (Trixie)

\- 4 cores, 8 GB RAM, 60 GB disk

\- Docker CE + Compose Plugin



\### Layer 4 — Networking

\- Cloudflare Tunnel (cloudflared) — exposes services without opening ports

\- Nginx Proxy Manager — routes traffic to each container by subdomain

\- Authelia — intercepts all requests and requires authentication



\### Layer 5 — Services

\- Each service runs in its own Docker container

\- All containers share the `homelab` Docker network

\- Data persists in named volumes under `/opt/homelab/`



\## Directory Layout on Server



/opt/homelab/

├── docker-compose.yml

├── nginx-proxy/

├── homepage/

├── vaultwarden/

├── filebrowser/

├── couchdb/

├── portainer/

├── authelia/

│ └── config/

│ ├── configuration.yml

│ └── users.yml

└── projects/

└── taller/ # CarMan workshop system





\## Authentication Flow



1\. User visits any subdomain

2\. Cloudflare Tunnel receives the request and forwards to NPM

3\. NPM checks with Authelia via `auth\_request`

4\. If not authenticated, Authelia redirects to `auth.ricardo-acuna.com`

5\. User logs in with username and password

6\. Authelia sets a session cookie valid for 1 month

7\. User is redirected to the original service



\## Remote Access



Tailscale is installed directly on the Proxmox host, creating a private mesh VPN. This allows accessing the Proxmox web UI and SSH from any device without exposing anything to the internet.



