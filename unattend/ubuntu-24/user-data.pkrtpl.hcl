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

  timezone: "UTC"

  updates: all
    
  late-commands:
    - lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
    - resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv

  user-data:
    hostname: ${var.vm_hostname}
    users:
      - name: root
        ssh_authorized_keys:
          - ${var.ssh_public_key}
    disable_root: false
    chpasswd:
      expire: false
      users:
      - {name: root, password: ${var.password}}