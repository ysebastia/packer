variable "boot_command" {
  type = list(string)
}

variable "disk_image" {
  type = string
}

variable "disk_size" {
  type = string
  default = "20G"
}

variable "iso_checksum" {
  type = string
}

variable "iso_url" {
  type = string
}

variable "name" {
  type = string
}

variable "provisioner_ansible" {
  type = string
  default = "provisioner/ansible/ping.yml"
}

variable "provisioner_shell" {
  type = list(string)
}

variable "ssh_password" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "sysprep" {
  type = string
}

variable "version" {
  type = string
}

variable "vnc_port" {
  type = number
}

source "qemu" "vagrant" {
  accelerator      = "kvm"
  boot_command     = var.boot_command
  boot_wait        = "10s"
  cpus             = 1
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  disk_image       = var.disk_image
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = false
  http_directory   = "files/http/${var.name}"
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  machine_type	   = "pc"
  memory           = 2048
  net_device       = "virtio-net"
  output_directory = "artifacts/${var.name}/"
  qemu_binary      = "/usr/libexec/qemu-kvm"
  qemuargs         = [
    ["-cpu", "host,+nx"],
    ["-display", "none"]
  ]
  shutdown_command = "sudo shutdown --poweroff --no-wall now"
  ssh_password     = var.ssh_password
  ssh_timeout      = "20m"
  ssh_username     = var.ssh_username
  vm_name          = var.name
  vnc_bind_address = "0.0.0.0"
  vnc_port_min     = var.vnc_port
  vnc_port_max     = var.vnc_port
}

build {
  sources = ["source.qemu.vagrant"]

  provisioner "ansible" {
    playbook_file          = var.provisioner_ansible
    extra_arguments        = ["--scp-extra-args", "'-O'"]
    ansible_ssh_extra_args = ["-o IdentitiesOnly=yes -o PubkeyAcceptedKeyTypes=+ssh-rsa -o HostkeyAlgorithms=+ssh-rsa"]
  }
  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = var.provisioner_shell
  }

  post-processors {
    post-processor "shell-local" {
      inline = [
        "set -eu",
        "virt-sysprep --operations ${var.sysprep} -a artifacts/${var.name}/${var.name}",
        "virt-sparsify --in-place artifacts/${var.name}/${var.name}",
        "qemu-img convert -f qcow2 -O qcow2 -c artifacts/${var.name}/${var.name} artifacts/${var.name}/${var.name}_${var.version}.img",
        ]
    }
    post-processor "vagrant" {
      keep_input_artifact = true
      compression_level   = 9
      output = "artifacts/${var.name}/${var.name}_vagrant_{{.Provider}}_${var.version}.box"
      provider_override   = "libvirt"
    }
    post-processor "shell-local" {
      inline = [
        "bash scripts/metadata.bash ${var.name} ${var.version} artifacts/${var.name}/${var.name}_vagrant_libvirt_${var.version}.box > artifacts/${var.name}/metadata.json",
        "rm -f artifacts/${var.name}/${var.name}"
        ]
    }
  }
}
