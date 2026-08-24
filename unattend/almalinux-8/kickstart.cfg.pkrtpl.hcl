#version=RHEL8

url --url="https://repo.almalinux.org/almalinux/8/BaseOS/x86_64/kickstart/"

repo --name="alamalinux8-baseos" --baseurl="https://repo.almalinux.org/almalinux/8/BaseOS/x86_64/os/" --mirrorlist=""
repo --name="alamalinux8-appstream" --baseurl="https://repo.almalinux.org/almalinux/8/AppStream/x86_64/os/" --mirrorlist=""


# Use text install
text

# Disable the Setup Agent on first boot
firstboot --disable

eula --agreed

# Do not configure the X Window System
skipx

# Reboot after the installation is complete
reboot

%packages
# @^minimal-environment
# @standard
kexec-tools
qemu-guest-agent

%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=ens18 --noipv6 --activate
network  --hostname=${var.vm_hostname}

ignoredisk --only-use=sda
# Partition clearing information
clearpart --all --initlabel 
# Disk partitioning information
part /boot/efi --fstype="efi" --ondisk=sda --size=600
part pv.1 --fstype="lvmpv" --ondisk=sda --grow
part /boot --fstype="xfs" --ondisk=sda --size=1024
volgroup vg0 --pesize=4096 pv.1
logvol / --fstype="xfs" --grow --percent=100 --name=root --vgname=vg0

# System timezone
timezone UTC --isUtc --nontp

# Root password
rootpw --iscrypted ${var.password}

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end

%post
sed -i '/^PermitRootLogin/c\PermitRootLogin prohibit-password' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

mkdir -p /root/.ssh
echo -e "${var.ssh_public_key}" > /root/.ssh/authorized_keys
chown -R root:root /root/.ssh
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

%end