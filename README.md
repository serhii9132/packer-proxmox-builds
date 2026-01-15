### Overview
Packer templates for creating VM images on Proxmox VE using the [proxmox-iso](https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso) builder.
All sensitive data is configured using environment variables. See the Usage section for details.

Available OS Images
- Ubuntu 24.04.3 LTS
- AlmaLinux 8.10
- Debian 13.3

### Template details
- CPU: 2 cores
- Disk: 100 Gb
- RAM: 4 Gb
- Partitioning: LVM
- Swap: Disabled
- Preinstalled packages: openssh-server, qemu-guest-agent
- User: with sudo privileges is created without password prompt.
- Root: enabled

### Tested With
- Packer: v1.14.3
- Proxmox VE: 9.1.4

### Usage
1. Clone the repository.
2. Create a .env file in the root of the project with the following content:
```sh
# Proxmox API credentials
PROXMOX_NAME_NODE=pve-node
PROXMOX_URL=https://192.168.111.111:8006/api2/json
PROXMOX_USER=packer@pam!packer-token
PROXMOX_TOKEN=aaabbbcc-dd11-ddee-1111-bbbbb1122323
PROXMOX_NAME_DATASTORE='local'

# SSH user configuration
SUDO_USER=user
SUDO_USER_PASSWORD='$6$example$hashedpasswordhere'  # Use: mkpasswd -m sha-512
SSH_PUB_KEY='ssh-ed25519 AAAAC3NzaC1... user@host'     # Public SSH key (RSA or ED25519)
SSH_PRIVATE_KEY_FILE=/home/user/.ssh/id_rsa

ROOT_PASSWORD='ssh-ed25519 AAAAC3NzaC2... user@host'
```
3. Run the following commands:
```sh
# Build an Ubuntu image
make ubuntu2404

# Build an AlmaLinux image
make almalinux8

# Build an Debian image
make debian13

```

