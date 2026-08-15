packer {
  required_plugins {
    proxmox = {
      version = "1.2.3"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu" {
  proxmox_url               = var.pve_url
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
    efi_storage_pool        = var.storage_pool_disks
  }

  disks {
    storage_pool            = var.storage_pool_disks
    disk_size               = var.disk_size
    format                  = var.format_disk
    io_thread               = var.is_io_thread
    type                    = var.type_bus
  }

  network_adapters {
    model                   = var.net_adapter_model
    bridge                  = var.net_name_bridge
    vlan_tag                = var.net_vlan_tag == "" ? null : var.net_vlan_tag
  }

  boot_iso {
    type                    = var.type_bus
    unmount                 = var.is_umount_iso
    iso_download_pve        = var.iso_download_pve
    iso_storage_pool        = var.storage_pool_iso
    iso_url                 = local.iso_url
    iso_checksum            = local.iso_checksum
  }

  additional_iso_files { 
    type                    = var.type_bus
    cd_content              = local.autoinstall_files
    cd_label                = var.cd_label
    iso_storage_pool        = var.storage_pool_iso
    unmount                 = var.is_umount_iso
  }

  ssh_username              = var.ssh_username
  ssh_private_key_file      = var.ssh_private_key_file
  ssh_timeout               = var.ssh_timeout

  qemu_agent                = var.is_qemu_agent

  boot_wait                 = var.boot_wait
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "ipv6.disable=1 <wait5>autoinstall ---<wait>",
    "<f10><wait>"
  ]
}

build {
  sources = ["sources.proxmox-iso.ubuntu"]

  provisioner "file" {
    source = "./provision/files/regenerate_ssh_host_keys.service"
    destination = "/tmp/regenerate_ssh_host_keys.service"
  }

  provisioner "shell" {
    scripts = [
      "provision/scripts/regenerate_ssh_host_keys.sh",
      "provision/scripts/cleanup.sh",
    ]
    execute_command = "{{ .Path }}"
  }
}