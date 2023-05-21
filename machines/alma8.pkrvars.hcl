boot_command      = ["<tab> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter><wait>"]
disk_image        = false
iso_checksum      = "sha256:016e59963c2c3bd4c99c18ac957573968e23da51131104568fbf389b11df3e05"
iso_url           = "file:///var/lib/libvirt/images/AlmaLinux-8.8-x86_64-boot.iso"
name              = "alma8"
provisioner_shell = ["provisioner/scripts/alma.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-customize"
version           = "8.8-20230551.0"
vnc_port          = 5993
