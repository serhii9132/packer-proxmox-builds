iso_checksum = "file:https://releases.ubuntu.com/noble/SHA256SUMS"
iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04.3-live-server-amd64.iso"

vm_name = "ubuntu-24"
vm_hostname = "ubuntu"

boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "ipv6.disable=1 <wait5>autoinstall ---<wait>",
    "<f10><wait>" 
]