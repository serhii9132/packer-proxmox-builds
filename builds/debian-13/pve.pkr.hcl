variable "proxmox_url" {
    type = string
    default = env("PROXMOX_URL")
}

variable "insecure_skip_tls_verify" {
    type = bool
    default = true
}

variable "pve_username" {
    type = string
    default = env("PROXMOX_USER")
}

variable "pve_token" {
    type = string
    default = env("PROXMOX_TOKEN")
}

variable "pve_node_name" {
    type = string
    default = env("PROXMOX_NAME_NODE")
}

variable "pve-name-datastore" {
    type = string
    default = env("PROXMOX_NAME_DATASTORE")
}