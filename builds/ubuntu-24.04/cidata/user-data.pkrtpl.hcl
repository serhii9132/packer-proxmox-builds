#cloud-config
autoinstall:
  version: 1

  source:
    search_drivers: false
    id: ubuntu-server-minimal

  storage:
    swap:
      size: 0
    layout:
      name: lvm

  ssh:
    install-server: true
    allow-pw: false

  packages:
    - qemu-guest-agent
    - rsync
    - bash-completion

  timezone: "Europe/Kyiv"

  updates: all
    
  late-commands:
    - lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
    - resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv

  user-data:
    hostname: ${var.vm_hostname}
    users:
      - name: ${var.sudo_user}
        passwd: ${var.sudo_user_pass}
        shell: /bin/bash
        lock_passwd: False
        groups: sudo
        sudo: "ALL=(ALL) NOPASSWD:ALL"
        ssh_authorized_keys:
         - ${var.ssh_public_key}
    chpasswd:
      expire: false
      users:
      - {name: root, password: ${var.root_password}}