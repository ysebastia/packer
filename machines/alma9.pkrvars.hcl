boot_command      = ["<tab> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter><wait>"]
disk_image        = false
iso_checksum      = "sha256:f501de55f92e59a3fcf4ad252fdfc4e02ee2ad013d2e1ec818bb38052bcb3c32"
iso_url           = "file:///var/lib/libvirt/images/AlmaLinux-9.2-x86_64-boot.iso"
name              = "alma9"
provisioner_shell = ["provisioner/scripts/alma.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-customize"
version           = "9.2-20230521.0"
vnc_port          = 5991
