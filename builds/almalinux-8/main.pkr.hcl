packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "almalinux" {
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

  additional_iso_files { 
    type                    = var.type_bus
    cd_content              = local.autoinstall_files
    cd_label                = var.cd_label
    iso_storage_pool        = var.pve-name-datastore
    unmount                 = var.is_umount_iso
  }

  ssh_username              = var.sudo_user
  ssh_private_key_file      = var.ssh_pivate_key_file
  ssh_timeout               = var.ssh_timeout

  qemu_agent                = var.is_qemu_agent

  boot_wait                 = var.boot_wait
  boot_command              = [
    "c<wait>",
    "linuxefi /images/pxeboot/vmlinuz",
    " ipv6.disable=1 inst.stage2=hd:LABEL=AlmaLinux-8-10-x86_64-dvd",
    " inst.ks=hd:LABEL=${var.cd_label}:/kickstart.cfg <wait><enter>",
    "initrdefi /images/pxeboot/initrd.img<enter>",
    "boot<enter><wait>",
  ]
}

build {
  sources = ["sources.proxmox-iso.almalinux"]

  provisioner "shell" {
    inline = [
      "sudo rm -f /etc/ssh/ssh_host_*",
      "sudo dnf clean all",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo rm -f /var/lib/dbus/machine-id",
      "sudo ln -s /etc/machine-id /var/lib/dbus/machine-id",
    ]
  }
}