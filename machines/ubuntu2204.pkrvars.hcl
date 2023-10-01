boot_command      = [
    "c<wait>",
    "set gfxpayload=keep",
    "<enter><wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" net.ifnames=0 ipv6.disable=1 biosdevname=0",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
]
disk_image        = false
iso_checksum      = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
iso_url           = "file:///var/lib/libvirt/images/ubuntu-22.04.3-live-server-amd64.iso"
name              = "ubuntu2204"
provisioner_shell = ["provisioner/scripts/dummy.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "22.04.3-20231001.0"
vnc_port          = 5995
