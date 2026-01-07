packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu" {
  proxmox_url               = var.proxmox_url
  insecure_skip_tls_verify  = var.insecure_skip_tls_verify
  username                  = var.pve_username
  token                     = var.pve_token
  node                      = var.pve_node_name
  task_timeout              = var.task_timeout

  vm_name                   = var.vm_name
  os                        = var.os
  cpu_type                  = var.cpu_type
  cores                     = var.cores
  sockets                   = var.sockets
  memory                    = var.memory
  scsi_controller           = var.scsi_controller
  serials                   = var.serials
  communicator              = var.communicator

  bios                      = var.bios
  efi_config {
    efi_storage_pool        = var.pve-name-datastore
  }

  disks {
    storage_pool            = var.pve-name-datastore
    disk_size               = var.disk_size
    format                  = var.format_disk
    io_thread               = var.is_io_thread
    type                    = var.type_bus
  }

  network_adapters {
    model                   = var.net_adapter_model
    bridge                  = var.net_adapter_bridge
  }

  boot_iso {
    type                    = var.type_bus
    unmount                 = var.is_umount_iso
    iso_download_pve        = var.iso_download_pve
    iso_storage_pool        = var.pve-name-datastore
    iso_url                 = local.iso_url
    iso_checksum            = local.iso_checksum
  }

  ssh_username              = var.sudo_user
  ssh_private_key_file      = var.ssh_pivate_key_file
  ssh_timeout               = var.ssh_timeout

  qemu_agent                = var.is_qemu_agent

  http_content              = local.autoinstall_files
  http_interface            = var.http_interface
  
  boot_wait                 = var.boot_wait
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "ipv6.disable=1 \"ds=nocloud-net;<wait5>s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" <wait5>autoinstall ---<wait>",
    "<f10><wait>"
  ]
}

build {
  sources = ["sources.proxmox-iso.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo rm -f /etc/ssh/ssh_host_*",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo truncate -s 0 /etc/machine-ide",
      "sudo rm -f /var/lib/dbus/machine-id",
      "sudo ln -s /etc/machine-id /var/lib/dbus/machine-id",
      "sudo cloud-init clean --logs --seed"
    ]
  }

  provisioner "file" {
    source = "./files/regenerate_ssh_host_keys.service"
    destination = "/tmp/regenerate_ssh_host_keys.service"
  }

  provisioner "shell" {
    inline = [
      "sudo cp /tmp/regenerate_ssh_host_keys.service /etc/systemd/system/regenerate-ssh-host-keys.service",
      "sudo chown root:root /etc/systemd/system/regenerate-ssh-host-keys.service",
      #"sudo systemd daemon-reload",
      "sudo systemctl enable regenerate-ssh-host-keys.service",
      "sudo rm /tmp/regenerate_ssh_host_keys.service"
    ]
  }
}