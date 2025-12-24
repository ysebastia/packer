boot_command     = [
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
iso_checksum     = "sha256:c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
iso_url          = "file:///var/lib/libvirt/images/ubuntu-24.04.3-live-server-amd64.iso"
name             = "ubuntu24"
provisioner_shell = ["provisioner/scripts/ubuntu.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version          = "24.04.3-20251224.0"
vnc_port         = 5999