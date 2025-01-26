boot_command      = ["<esc><wait>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
disk_image        = false
iso_checksum      = "sha256:04396d12b0f377958a070c38a923c227832fa3b3e18ddc013936ecf492e9fbb3"
iso_url           = "file:///var/lib/libvirt/images/debian-12.9.0-amd64-netinst.iso"
name              = "debian12"
provisioner_shell = ["provisioner/scripts/debian.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "12.9.0-20241117.0"
vnc_port          = 5992
