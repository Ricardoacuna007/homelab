# Proxmox VE Setup Guide

## Requirements

- USB drive (2 GB minimum)
- Proxmox VE ISO — download from proxmox.com/downloads
- Rufus (Windows) or dd (Linux) to flash the USB

## 1. Flash the ISO

Use Rufus with DD mode (selected automatically for ISOHybrid images).

## 2. Boot from USB

Press F12 on the Dell OptiPlex 3080M to open the boot menu and select the USB drive.

## 3. Install Proxmox VE

- Target disk: NVMe SSD
- Hostname: hackriki (or your preferred name)
- IP address: set a static IP (e.g. 192.168.0.50)
- Password: use only letters and numbers (keyboard is in English during install)

## 4. Disable Enterprise Repositories

After installation, open the Proxmox shell and run:

```bash
printf "Enabled: no\nTypes: deb\nURIs: https://enterprise.proxmox.com/debian/ceph-squid\nSuites: trixie\nComponents: enterprise\nSigned-By: /usr/share/keyrings/proxmox-archive-keyring.gpg\n" > /etc/apt/sources.list.d/ceph.sources

printf "Enabled: no\nTypes: deb\nURIs: https://enterprise.proxmox.com/debian/pve\nSuites: trixie\nComponents: pve-enterprise\nSigned-By: /usr/share/keyrings/proxmox-archive-keyring.gpg\n" > /etc/apt/sources.list.d/pve-enterprise.sources

echo "deb http://download.proxmox.com/debian/pve trixie pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list

apt-get update && apt-get upgrade -y
```

## 5. Install Tailscale on Proxmox

```bash
curl -fsSL https://pkgs.tailscale.com/stable/debian/trixie.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/trixie.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list
apt update && apt install -y tailscale
tailscale up
```

Authenticate via the URL provided. Proxmox will be accessible at its Tailscale IP on port 8006.

## 6. Create the Homelab VM

| Setting | Value |
|---|---|
| OS | Debian 13 netinst ISO |
| CPU | 4 cores |
| RAM | 8192 MB |
| Disk | 60 GB VirtIO |
| Network | VirtIO, bridge vmbr0 |
| Qemu Agent | Enabled |

During Debian installation, select only SSH server and standard system utilities (options 11 12).
