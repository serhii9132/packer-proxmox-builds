packer {
  required_plugins {
    proxmox = {
      version = "1.2.3"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "base-linux" {
  proxmox_url               = var.pve_url
  insecure_skip_tls_verify  = var.insecure_skip_tls_verify
  username                  = var.pve_username
  token                     = var.pve_token
  node                      = var.pve_node_name
  task_timeout              = var.task_timeout

  vm_name                   = var.vm_name
  template_name             = "${var.vm_name}-tmpl" 
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
    storage_pool           = var.storage_pool_disks
    disk_size              = var.disk_size
    format                 = var.format_disk
    io_thread              = var.is_io_thread
    type                   = var.type_bus
  }

  network_adapters {
    model                  = var.net_adapter_model
    bridge                 = var.net_name_bridge
    vlan_tag               = var.net_vlan_tag == "" ? null : var.net_vlan_tag
  }

  boot_iso {
    type                   = var.type_bus
    unmount                = var.is_umount_iso
    iso_download_pve       = var.iso_download_pve
    iso_storage_pool       = var.storage_pool_iso
    iso_url                = var.iso_url
    iso_checksum           = var.iso_checksum
  }

  ssh_username             = var.ssh_username
  ssh_private_key_file     = var.ssh_private_key_file
  ssh_timeout              = var.ssh_timeout

  qemu_agent               = var.is_qemu_agent

  boot_wait                = var.boot_wait
  boot_command             = var.boot_command
}

build {
   source "source.proxmox-iso.base-linux" {
    name                = "ubuntu-24"
    
    additional_iso_files { 
      type              = var.type_bus
      cd_label          = var.cd_label
      iso_storage_pool  = var.storage_pool_iso
      unmount           = var.is_umount_iso
      cd_content        = {
        "/meta-data" = file(abspath("${path.root}/unattend/${var.vm_name}/meta-data"))
        "/user-data" = templatefile(abspath("${path.root}/unattend/${var.vm_name}/user-data.pkrtpl.hcl"), { var = var })
      }
    }
  }

  source "source.proxmox-iso.base-linux" {
    name                = "debian-13"
    
    additional_iso_files { 
      type              = var.type_bus
      cd_label          = var.cd_label
      iso_storage_pool  = var.storage_pool_iso
      unmount           = var.is_umount_iso
      cd_content        = {
        "/preseed.cfg" = templatefile(abspath("${path.root}/unattend/${var.vm_name}/preseed.cfg.pkrtpl.hcl"), { var = var })
      }
    }
  }

  source "source.proxmox-iso.base-linux" {
    name                = "almalinux-8"
    
    additional_iso_files { 
      type              = var.type_bus
      cd_label          = var.cd_label
      iso_storage_pool  = var.storage_pool_iso
      unmount           = var.is_umount_iso
      cd_content        = {
        "/kickstart.cfg" = templatefile(abspath("${path.root}/unattend/${var.vm_name}/kickstart.cfg.pkrtpl.hcl"), { var = var })
      }
    }
  }

  provisioner "file" {
    source      = "${path.root}/provision/files/reconfigure_ssh_host_keys.service"
    destination = "/tmp/reconfigure_ssh_host_keys.service"
    only        = ["proxmox-iso.ubuntu-24", "proxmox-iso.debian-13"]
  }

  provisioner "shell" {
    script      = "${path.root}/provision/scripts/reconfigure_ssh_host_keys.sh"
    only        = ["proxmox-iso.ubuntu-24", "proxmox-iso.debian-13"]
  }

  provisioner "shell" {
    script      = "${path.root}/provision/scripts/cleanup.sh"
  }
}