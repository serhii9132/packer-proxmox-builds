d-i preseed/early_command string umount /mnt/cdrom2 && echo 1 > /sys/block/sr1/device/delete

# Set OS locale
d-i debian-installer/language string en
d-i debian-installer/country string UA
d-i debian-installer/locale string en_US.UTF-8

# Set the keyboard layout
d-i keyboard-configuration/xkb-keymap select us

# Network configuration
d-i netcfg/choose_interface select auto

# # Mirror from which packages will be downloaded
d-i mirror/protocol string http
d-i mirror/country string UA
d-i mirror/http/hostname string deb.debian.org
d-i mirror/http/mirror select deb.debian.org
d-i mirror/http/directory string /debian/
d-i mirror/http/proxy string

# Configure hardware clock
d-i clock-setup/utc boolean true

# Set timezone
d-i time/zone string Europe/Kyiv

# Create root uer 
d-i passwd/root-login boolean true
d-i passwd/root-password-crypted password ${var.root_password}

# Create a normal user account
d-i passwd/user-fullname string ${var.sudo_user}
d-i passwd/username string ${var.sudo_user}
d-i passwd/user-password-crypted password ${var.sudo_user_pass}

# Disk configuration
d-i partman-auto/method string lvm
d-i partman-auto-lvm/guided_size string max
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto/expert_recipe string \
        part :: \
                538 538 1075 free \
                        $iflabel{ gpt } \
                        $reusemethod{ } \
                        method{ efi } \
                        format{ } \
                        . \
                128 512 256 ext2 \
                        $defaultignore{ } \
                        method{ format } format{ } \
                        use_filesystem{ } filesystem{ ext2 } \
                        mountpoint{ /boot } \
                        . \
                1000 100000 -1 ext4 \
                        $lvmok{ } lv_name{ root } \
                        method{ format } format{ } \
                        use_filesystem{ } filesystem{ ext4 } \
                        mountpoint{ / } \
                        . \

d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
# Skip create swap partition
d-i partman-basicfilesystems/no_swap boolean false

# Force UEFI booting
d-i partman-efi/non_efi_system boolean true
# Ensure the partition table is GPT - this is required for EFI
d-i partman-partitioning/choose_label select gpt
d-i partman-partitioning/default_label string gpt

# Bootloader options
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true
d-i grub-installer/bootdev string /dev/sda
d-i grub-installer/force-efi-extra-removable boolean true

# Do not scan additional CDs
d-i apt-setup/cdrom/set-first boolean false

# Use network mirror
d-i apt-setup/use_mirror boolean true

# Select base install
tasksel tasksel/first multiselect ssh-server

# Extra packages to be installed
d-i pkgsel/include string sudo python3 python3-apt wget rsync bash-completion qemu-guest-agent

# Disable polularity contest
popularity-contest popularity-contest/participate boolean false

# Whether to upgrade packages after debootstrap
d-i pkgsel/upgrade select full-upgrade

# Umount ISO after installation
d-i cdrom-detect/eject boolean false

# Reboot once the install is done
d-i finish-install/reboot_in_progress note

d-i preseed/late_command string \
 in-target bash -c 'echo "PasswordAuthentication no" >> /etc/ssh/sshd_config.d/50-cloud-init.conf'; \
 in-target bash -c 'echo "${var.sudo_user} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${var.sudo_user}'; \
 in-target usermod -aG sudo ${var.sudo_user}; \
 in-target mkdir -p /home/${var.sudo_user}/.ssh; \
 in-target bash -c 'echo "${var.ssh_public_key}" > /home/${var.sudo_user}/.ssh/authorized_keys'; \
 in-target chown -R ${var.sudo_user}:${var.sudo_user} /home/${var.sudo_user}/.ssh; \
 in-target chmod 700 /home/${var.sudo_user}/.ssh; \
 in-target chmod 600 /home/${var.sudo_user}/.ssh/authorized_keys