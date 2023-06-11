boot_command      = ["<esc><wait>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
disk_image        = false
iso_checksum      = "sha256:3b0e9718e3653435f20d8c2124de6d363a51a1fd7f911b9ca0c6db6b3d30d53e"
iso_url           = "file:///var/lib/libvirt/images/debian-12.0.0-amd64-netinst.iso"
name              = "debian12"
provisioner_shell = ["provisioner/scripts/debian.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "12.0.0-20230611.0"
vnc_port          = 5992
