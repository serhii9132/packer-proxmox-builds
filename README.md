### Overview
Packer template for creating VM images on Proxmox VE using the [proxmox-iso](https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso) builder.

Available OS images:
- Ubuntu 24.04.3 LTS
- AlmaLinux 8.10
- Debian 13.6

### Template details
- CPU: 2 cores
- CPU type: host
- Disk: 100 Gb
- RAM: 4 Gb
- Partitioning: LVM
- Swap: Disabled
- Preinstalled packages: openssh-server, qemu-guest-agent
- Root: enabled

### Tested With
- Packer: v1.16
- Proxmox VE: 9.2.2

### Usage
1. Clone the repository.
2. Create a local.pkrvars.hcl file in the root of the project with the following content:
```sh
# Proxmox API credentials
pve_url = https://192.168.111.111:8006/api2/json
pve_node_name = pve-node
pve_username = packer@pam!packer-token
pve_token = aabbbcc-dd11-ddee-1111-bbbbb1122323

net_name_bridge = vmbr1
net_vlan_tag = 10

storage_pool_disks = local2

password = '$6$example$hashedpasswordhere'  # Use: mkpasswd -m sha-512

ssh_public_key = 'ssh-ed25519 AAAAC3NzaC1... user@host'     # Public SSH key (RSA or ED25519)
ssh_private_key_file = /home/user/.ssh/id_rsa
```
3. Run the following commands:
```sh
make ubuntu-24

make almalinux-8

make debian-13
```