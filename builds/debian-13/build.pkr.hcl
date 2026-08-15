locals {
  iso_checksum = "file:https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS"
  name_iso_file = "debian-13.6.0-amd64-netinst.iso"
  iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/${local.name_iso_file}"
  
  autoinstall_files = {
      "/preseed.cfg" = templatefile(abspath("${path.root}/${var.cd_label}/preseed.cfg.pkrtpl.hcl"), { var = var })
  }
}

variable "task_timeout" {
  type = string
}

variable "vm_name" {
  type = string
  default = "debian-13"
}

variable "os" {
  type = string
}

variable "cpu_type" {
  type = string
}

variable "cores" {
  type = number
}

variable "sockets" {
  type = number
}

variable "memory" {
  type = number
}

variable "scsi_controller" {
  type = string
}

variable "serials"{
  type = list(string)
}

variable "communicator" {
  type = string
}

variable "bios" {
  type = string
}

variable "type_bus" {
  type = string
}

variable "is_umount_iso" {
  type = bool
}

variable "iso_download_pve" {
  type = bool
}

variable "disk_size" {
  type = string
}

variable "format_disk" {
  type = string
}

variable "is_io_thread" {
  type = bool
}

variable "net_adapter_model" {
  type = string
}

variable "net_name_bridge" {
  type = string
}

variable "net_vlan_tag" {
  type = string
}

variable "is_qemu_agent" {
  type = bool
}

variable "boot_wait" {
  type = string
}

variable "vm_hostname" {
  type = string
  default = "debian"
}

variable "cd_label" {
  type = string
}