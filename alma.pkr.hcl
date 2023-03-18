variable "boot_command" {
  type = string
}

variable "name" {
  type = string
}

variable "version" {
  type = string
}

variable "iso_checksum" {
  type = string
}

variable "iso_url" {
  type = string
}

variable "provisioner_shell" {
  type = string
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

variable "vnc_port" {
  type = string
}

source "qemu" "alma" {
  accelerator      = "kvm"
  boot_command     = [var.boot_command]
  boot_wait        = "10s"
  cpus             = "1"
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  disk_interface   = "virtio"
  disk_size        = "20G"
  format           = "qcow2"
  headless         = false
  http_directory   = "http/${var.name}"
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  machine_type	   = "pc"
  memory           = "2048"
  net_device       = "virtio-net"
  output_directory = "artifacts/${var.name}/"
  qemu_binary      = "/usr/libexec/qemu-kvm"
  qemuargs         = [
    ["-m", "2048M"],
    ["-smp", "1"],
    ["-cpu", "host,+nx"],
    ["-display", "none"]
  ]
  shutdown_command = "sudo shutdown --poweroff --no-wall now"
  ssh_password     = var.ssh_password
  ssh_timeout      = "20m"
  ssh_username     = var.ssh_username
  vm_name          = var.name
  vnc_port_min     = var.vnc_port
  vnc_port_max     = var.vnc_port
}

build {
  sources = ["source.qemu.alma"]

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = [ "${var.provisioner_shell}" ]
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
        "bash scripts/metadata.bash ${var.name} ${var.version} artifacts/${var.name}/${var.name}_vagrant_libvirt_${var.version}.box > artifacts/${var.name}/metadata.json"
        ]
    }
  }
}
