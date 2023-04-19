boot_command      = ["<tab> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter><wait>"]
disk_image        = false
iso_checksum      = "sha256:a4fc8c53878e09f63849f2357228db9e2b547beea6f2b47758da2995bd59356e"
iso_url           = "file:///var/lib/libvirt/images/AlmaLinux-8.7-x86_64-boot.iso"
name              = "alma8"
provisioner_shell = ["provisioner/scripts/alma.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-customize"
version           = "8.7-20230419.0"
vnc_port          = 5903