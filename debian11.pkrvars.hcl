boot_command      = ["<esc><wait>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
disk_image        = false
iso_checksum      = "sha256:e482910626b30f9a7de9b0cc142c3d4a079fbfa96110083be1d0b473671ce08d"
iso_url           = "file:///var/lib/libvirt/images/debian-11.6.0-amd64-netinst.iso"
name              = "debian11"
provisioner_shell = ["provisioner/scripts/debian.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "11.6.0-3"
vnc_port          = 5902
