insecure_skip_tls_verify = true

task_timeout = "15m"

os = "l26"
cpu_type = "host"
cores = 2
sockets = 1
memory = 4096
scsi_controller = "virtio-scsi-single"
serials = ["socket"]

communicator = "ssh"

bios = "ovmf"

type_bus = "scsi"
is_umount_iso = true
iso_download_pve = true

disk_size = "100G"
format_disk = "qcow2"
is_io_thread = true

net_adapter_model = "virtio"

storage_pool_iso = "local"

ssh_timeout = "30m"
ssh_username = "root"

is_qemu_agent = true

boot_wait = "10s"

cd_label = "cidata"