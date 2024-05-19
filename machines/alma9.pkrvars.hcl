boot_command      = ["<tab> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg<enter><wait>"]
disk_image        = false
iso_checksum      = "sha256:af5377a1d16bbe599ea91a8761ad645f2f54687075802bdc0c0703ee610182e9"
iso_url           = "file:///var/lib/libvirt/images/AlmaLinux-9.4-x86_64-boot.iso"
name              = "alma9"
provisioner_shell = ["provisioner/scripts/alma.bash"]
ssh_password      = "vagrant"
ssh_username      = "vagrant"
sysprep           = "defaults,-ssh-userdir,-customize"
version           = "9.3-20231214.0"
vnc_port          = 5991
