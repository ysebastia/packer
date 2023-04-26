boot_command      = ["<tab> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter><wait>"]
disk_image        = false
iso_checksum      = "sha256:9f22bd98c8930b1d0b2198ddd273c6647c09298e10a0167197a3f8c293d03090"
iso_url           = "file:///var/lib/libvirt/images/AlmaLinux-9.1-x86_64-boot.iso"
name              = "alma9"
provisioner_shell = ["provisioner/scripts/alma.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-customize"
version           = "9.1-20230419.0"
vnc_port          = 5991
