iso_checksum = "sha256:cc3e61faf2dd6c9c80d3beeb47eaaba235ac13fe1b617209c3c1e546528ccb99"
iso_url = "https://repo.almalinux.org/almalinux/8.10/isos/x86_64/AlmaLinux-8.10-x86_64-boot.iso"

vm_name = "almalinux-8"
vm_hostname = "almalinux"

boot_command = [
    "c<wait>",
    "linuxefi /images/pxeboot/vmlinuz",
    " ipv6.disable=1 inst.stage2=hd:LABEL=AlmaLinux-8-10-x86_64-dvd",
    " inst.ks=hd:LABEL=cidata:/kickstart.cfg <wait><enter>",
    "initrdefi /images/pxeboot/initrd.img<enter>",
    "boot<enter><wait>"
]