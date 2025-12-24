boot_command      = ["<esc><wait>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
disk_image        = false
iso_checksum      = "sha256:677c4d57aa034dc192b5191870141057574c1b05df2b9569c0ee08aa4e32125d"
iso_url           = "file:///var/lib/libvirt/images/debian-13.2.0-amd64-netinst.iso"
name              = "debian13"
provisioner_shell = ["provisioner/scripts/debian.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "13.2.0-20251224.0"
vnc_port          = 5992
