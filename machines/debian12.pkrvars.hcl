boot_command      = ["<esc><wait>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
disk_image        = false
iso_checksum      = "sha256:23ab444503069d9ef681e3028016250289a33cc7bab079259b73100daee0af66"
iso_url           = "file:///var/lib/libvirt/images/debian-12.2.0-amd64-netinst.iso"
name              = "debian12"
provisioner_shell = ["provisioner/scripts/debian.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-ssh-hostkeys,-customize"
version           = "12.2.0-20231009.0"
vnc_port          = 5992
