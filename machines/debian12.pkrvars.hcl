boot_command      = ["<esc><wait>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
disk_image        = false
iso_checksum      = "sha256:013f5b44670d81280b5b1bc02455842b250df2f0c6763398feb69af1a805a14f"
iso_url           = "file:///var/lib/libvirt/images/debian-12.6.0-amd64-netinst.iso"
name              = "debian12"
provisioner_shell = ["provisioner/scripts/debian.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "12.6.0-20240630.0"
vnc_port          = 5992
