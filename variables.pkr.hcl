variable "pve_url" {
    type = string
}

variable "insecure_skip_tls_verify" {
    type = bool
}

variable "pve_username" {
    type = string
}

variable "pve_token" {
    type = string
}

variable "pve_node_name" {
    type = string
}

variable "storage_pool_iso" {
    type = string
}

variable "storage_pool_disks" {
    type = string
}

variable "task_timeout" {
  type = string
}

variable "vm_name" {
  type = string
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

variable "iso_checksum" {
  type = string
}

variable "iso_url" {
  type = string
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
}

variable "cd_label" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "ssh_timeout" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "ssh_private_key_file" {
  type = string
}

variable "password" {
  type = string
}

variable "boot_command" {
  type = list(string)
}