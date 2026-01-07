locals {
  iso_checksum = "sha256:cc3e61faf2dd6c9c80d3beeb47eaaba235ac13fe1b617209c3c1e546528ccb99"
  name_iso_file = "AlmaLinux-8.10-x86_64-boot.iso"
  iso_url = "https://repo.almalinux.org/almalinux/8.10/isos/x86_64/${local.name_iso_file}"
  
  http_dir = "http"
  autoinstall_files = {
    "/kickstart.cfg" = templatefile("./${local.http_dir}/kickstart.cfg.pkrtpl.hcl", { var = var })
  }
}

variable "task_timeout" {
  type = string
}

variable "vm_name" {
  type = string
  default = "almalinux-8"
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
  default = "almalinux"
}