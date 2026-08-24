iso_checksum = "file:https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS"
iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.6.0-amd64-netinst.iso"

vm_name = "debian-13"
vm_hostname = "debian"

boot_command = [
    "<wait3>c<wait3>",
    "linux /install.amd/vmlinuz ",
    "auto-install/enable=true priority=critical preseed/file=/mnt/cdrom2/preseed.cfg ",
    "netcfg/hostname=debian netcfg/get_hostname=debian netcfg/get_domain='' ",
    "ipv6.disable=1 vga=788 noprompt quiet --<enter>",
    "initrd /install.amd/initrd.gz<enter>",
    "boot<enter>",
    "<wait10><esc><wait><esc><wait><enter><wait>",
    "<leftAltOn><f2><leftAltOff>",
    "<enter><wait>",
    "mkdir /mnt/cdrom2<enter>",
    "mount /dev/sr1 /mnt/cdrom2<enter>",
    "<leftAltOn><f1><leftAltOff><wait5>",
    "<esc><wait><enter>"
]