locals {
  iso_checksum = "file:https://releases.ubuntu.com/noble/SHA256SUMS"
  name_iso_file = "ubuntu-24.04.3-live-server-amd64.iso"
  iso_url = "https://releases.ubuntu.com/noble/${local.name_iso_file}"
  
  http_dir = "http"
  autoinstall_files = {
      "/meta-data" = file("./${local.http_dir}/meta-data")
      "/user-data" = templatefile("./${local.http_dir}/user-data.pkrtpl.hcl", { var = var })
  }
}

variable "task_timeout" {
  type = string
}

variable "vm_name" {
  type = string
  default = "ubuntu-24.04-lts"
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

variable "net_adapter_bridge" {
  type = string
}

variable "ssh_timeout" {
  type = string
}

variable "is_qemu_agent" {
  type = bool
}

variable "http_interface" {
  type = string
  default = env("HTTP_INTERFACE")
}

variable "boot_wait" {
  type = string
}

variable "vm_hostname" {
  type = string
  default = "ubuntu"
}