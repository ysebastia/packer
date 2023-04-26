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
iso_checksum      = "sha256:5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
iso_url           = "file:///var/lib/libvirt/images/ubuntu-22.04.2-live-server-amd64.iso"
name              = "ubuntu2204"
provisioner_shell = ["provisioner/scripts/dummy.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "22.04.2-20230419.0"
vnc_port          = 5995
